package path2ereg;

import haxe.DynamicAccess;

using StringTools;

typedef Key = {
	name: String,
	prefix: String,
	delimiter: String,
	optional: Bool,
	repeat: Bool,
	partial: Bool,
	asterisk: Bool,
	pattern: String
}

enum Token {
	Static(token: String);
	Capture(key: Key);
}

typedef Options = {
	?strict: Bool,
	?end: Bool,
	?sensitive: Bool
}

// Port of: https://github.com/pillarjs/path-to-regexp

class Path2EReg {
	
	public static function parse(str: String) {
		var matcher = new EReg([
				'(\\\\.)',
				'([\\/.])?(?:(?:\\:(\\w+)(?:\\(((?:\\\\.|[^\\\\()])+)\\))?|\\(((?:\\\\.|[^\\\\()])+)\\))([+*?])?|(\\*))'
			].join('|'), 'g'),
			tokens: Array<Token> = [],
			key = 0,
			index = 0,
			path = '';

		matcher.map(str, function (matcher) {
			function matched(index)
				return try matcher.matched(index) catch(e: Dynamic) null;

			var m = matched(0),
				escaped = matched(1),
				offset = matcher.matchedPos().pos;
				
			path += str.substring(index, offset);
			index = offset + m.length;
			
			if (escaped != null) {
				path += escaped.charAt(1);
				return '';
			}

			var next = str.charAt(index),
				prefix = matched(2),
				name = matched(3),
				capture = matched(4),
				group = matched(5),
				modifier = matched(6),
				asterisk = matched(7),
				delimiter = prefix == null ? '/' : prefix;

			if (path != '') {
				tokens.push(Static(path));
				path = '';
			}

			tokens.push(Capture({
				name: name == null ? '${key++}' : name,
				prefix: prefix == null ? '' : prefix,
				delimiter: delimiter,
				optional: modifier == '?' || modifier == '*',
				repeat: modifier == '+' || modifier == '*',
				partial: prefix != null && next != '' && next != prefix,
				asterisk: asterisk != null,
				pattern: escapeGroup(switch [capture, group, asterisk] {
					case [null, null, null]: '[^' + delimiter + ']+?';
					case [null, null, x]: '.*';
					case [null, x, _]: x;
					case [x, _, _]: x;
				})
			}));
			
			return '';
		});
		
		if (index < str.length)
			path += str.substr(index);

		if (path != '')
			tokens.push(Static(path));

		return tokens;
	}

	static function tokensToEReg(tokens: Array<Token>, ?options: Options) {
		options = defaults(options);
		
		var strict = options.strict,
			end = options.end,
			route: String = '',
			lastToken = tokens[tokens.length - 1],
			endsWithSlash = switch (lastToken) {
				case Static(token): token.charAt(token.length - 1) == '/';
				default: false;
			}

		for (token in tokens) switch token {
			case Static(token):
				route += escapeString(token);
			case Capture(token):
				var prefix = escapeString(token.prefix),
					capture = '(?:' + token.pattern + ')';

				if (token.repeat)
					capture += '(?:' + prefix + capture + ')*';
					
				if (token.optional)
					if (!token.partial)
						capture = '(?:' + prefix + '(' + capture + '))?';
					else
						capture = prefix + '(' + capture + ')?';
				else
					capture = prefix + '(' + capture + ')';
				
				route += capture;
		}
		
		if (!strict)
			route = (endsWithSlash ? route.substr(0, route.length-2) : route) + '(?:\\/(?=$))?';

		if (end)
			route += '$';
		else
			route += strict && endsWithSlash ? '' : '(?=\\/|$)';

		return new EReg('^' + route, flags(options));
	}
	
	static function tokensToFunction (tokens: Array<Token>) {
		
		var matches = [for (token in tokens) switch token {
			case Capture(key): new EReg('^(?:' + key.pattern + ')$', '');
			default: null;
		}];

		return function (obj: Dynamic, ?opts) {
			var path = '',
				data: DynamicAccess<Dynamic> = obj,
				options = defaults(opts);
				
			for (i in 0 ... tokens.length) switch tokens[i] {
				case Static(token): path += token;
				case Capture(token):
					var value = data[token.name],
						segment;
						
					if (value == null) {
						if (token.optional) {
							if (token.partial)
								path += token.prefix;
							continue;
						} else {
							throw 'Expected "' + token.name + '" to be defined';
						}
					}
					
					if (Std.is(value, Array) && token.repeat) {
						var arrayValue: Array<String> = cast value;
						if (arrayValue.length == 0)
							if (token.optional)
								continue;
						else
							throw 'Expected "' + token.name + '" to not be empty';
						
						for (j in 0 ... arrayValue.length) {
							var part = arrayValue[j];
							segment = StringTools.urlEncode(part);
							
							if (!matches[i].match(segment))
								throw 'Expected all "' + token.name + '" to match "' + token.pattern + '", but received `' + segment + '`';
							
							path += (j == 0 ? token.prefix : token.delimiter) + segment;
						}
						
						continue;
					}
					
					var stringValue: String = cast value;
					segment = token.asterisk ? encodeAsterisk(stringValue) : StringTools.urlEncode(stringValue);
					
					if (!matches[i].match(segment))
						throw 'Expected "' + token.name + '" to match "' + token.pattern + '", but received "' + segment + '"';
					path += token.prefix + segment;
			}
			
			return path;
		}
		
	}

	static function defaults(?options: Options): Options {
		options = options == null ? {} : options;
		return {
			strict: options.strict == null ? false : options.strict,
			end: options.end == null ? true : options.end,
			sensitive: options.sensitive == null ? false : options.sensitive
		}
	}
	
	static function escapeGroup(group: String)
		return ~/([=!:$\/()])/g.replace(group, '\\$1');
		
	static function escapeString(str: String)
		return ~/([.+*?=^!:${}()[\]|\/\\])/g.replace(str, '\\$1');
		
	static function flags(options)
		return options.sensitive ? '' : 'i';
		
	static function encodeAsterisk(str)
		return ~/[?#]/g.map(str, function (matcher) {
			var c = matcher.matched(0);
			return '%' + StringTools.hex(c.charCodeAt(0)).toUpperCase();
		});
		
	public static function compile(str)
		return tokensToFunction(parse(str));
	
	public static function toEReg(path, ?options) {
		var tokens = parse(path),
			keys = [];
		for (token in tokens) switch token {
			case Capture(key): keys.push(key);
			default: continue;
		}
		return {
			ereg: tokensToEReg(tokens, options),
			keys: keys
		}
	}
	
}