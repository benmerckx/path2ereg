package tests;

// Source: https://github.com/pillarjs/path-to-regexp/blob/master/src/index.spec.ts

final tests: Array<Dynamic> = [
	/**
	 * Simple paths.
	 */
	[
	'/',
	null,
	[
		'/'
	],
	[
		['/', ['/']],
		['/route', null]
	],
	[
		[null, '/'],
		[{}, '/'],
		[{ id: 123 }, '/']
	]
	],
	[
	'/test',
	null,
	[
		'/test'
	],
	[
		['/test', ['/test']],
		['/route', null],
		['/test/route', null],
		['/test/', ['/test/']]
	],
	[
		[null, '/test'],
		[{}, '/test']
	]
	],
	[
	'/test/',
	null,
	[
		'/test/'
	],
	[
		['/test', ['/test']],
		['/test/', ['/test/']],
		['/test//', null]
	],
	[
		[null, '/test/']
	]
	],

	/**
	 * Case-sensitive paths.
	 */
	[
	'/test',
	{
		sensitive: true
	},
	[
		'/test'
	],
	[
		['/test', ['/test']],
		['/TEST', null]
	],
	[
		[null, '/test']
	]
	],
	[
	'/TEST',
	{
		sensitive: true
	},
	[
		'/TEST'
	],
	[
		['/test', null],
		['/TEST', ['/TEST']]
	],
	[
		[null, '/TEST']
	]
	],

	/**
	 * Strict mode.
	 */
	[
	'/test',
	{
		strict: true
	},
	[
		'/test'
	],
	[
		['/test', ['/test']],
		['/test/', null],
		['/TEST', ['/TEST']]
	],
	[
		[null, '/test']
	]
	],
	[
	'/test/',
	{
		strict: true
	},
	[
		'/test/'
	],
	[
		['/test', null],
		['/test/', ['/test/']],
		['/test//', null]
	],
	[
		[null, '/test/']
	]
	],

	/**
	 * Non-ending mode.
	 */
	[
	'/test',
	{
		end: false
	},
	[
		'/test'
	],
	[
		['/test', ['/test']],
		['/test/', ['/test/']],
		['/test/route', ['/test']],
		['/route', null]
	],
	[
		[null, '/test']
	]
	],
	[
	'/test/',
	{
		end: false
	},
	[
		'/test/'
	],
	[
		['/test/route', ['/test']],
		['/test//', ['/test']],
		['/test//route', ['/test']]
	],
	[
		[null, '/test/']
	]
	],
	[
	'/:test',
	{
		end: false
	},
	[
		{
		name: 'test',
		prefix: '/',
		delimiter: '/',
		optional: false,
		repeat: false,
		partial: false,
		asterisk: false,
		pattern: '[^\\/]+?'
		}
	],
	[
		['/route', ['/route', 'route']]
	],
	[
		[{}, null],
		[{ test: 'abc' }, '/abc']
	]
	],
	[
	'/:test/',
	{
		end: false
	},
	[
		{
		name: 'test',
		prefix: '/',
		delimiter: '/',
		optional: false,
		repeat: false,
		partial: false,
		asterisk: false,
		pattern: '[^\\/]+?'
		},
		'/'
	],
	[
		['/route', ['/route', 'route']]
	],
	[
		[{ test: 'abc' }, '/abc/']
	]
	],

	/**
	 * Combine modes.
	 */
	[
	'/test',
	{
		end: false,
		strict: true
	},
	[
		'/test'
	],
	[
		['/test', ['/test']],
		['/test/', ['/test']],
		['/test/route', ['/test']]
	],
	[
		[null, '/test']
	]
	],
	[
	'/test/',
	{
		end: false,
		strict: true
	},
	[
		'/test/'
	],
	[
		['/test', null],
		['/test/', ['/test/']],
		['/test//', ['/test/']],
		['/test/route', ['/test/']]
	],
	[
		[null, '/test/']
	]
	],
	[
	'/test.json',
	{
		end: false,
		strict: true
	},
	[
		'/test.json'
	],
	[
		['/test.json', ['/test.json']],
		['/test.json.hbs', null],
		['/test.json/route', ['/test.json']]
	],
	[
		[null, '/test.json']
	]
	],
	[
	'/:test',
	{
		end: false,
		strict: true
	},
	[
		{
		name: 'test',
		prefix: '/',
		delimiter: '/',
		optional: false,
		repeat: false,
		partial: false,
		asterisk: false,
		pattern: '[^\\/]+?'
		}
	],
	[
		['/route', ['/route', 'route']],
		['/route/', ['/route', 'route']]
	],
	[
		[{}, null],
		[{ test: 'abc' }, '/abc']
	]
	],
	[
	'/:test/',
	{
		end: false,
		strict: true
	},
	[
		{
		name: 'test',
		prefix: '/',
		delimiter: '/',
		optional: false,
		repeat: false,
		partial: false,
		asterisk: false,
		pattern: '[^\\/]+?'
		},
		'/'
	],
	[
		['/route', null],
		['/route/', ['/route/', 'route']]
	],
	[
		[{ test: 'foobar' }, '/foobar/']
	]
	],

	/**
	 * Non-ending simple path.
	 */
	[
	'/test',
	{
		end: false
	},
	[
		'/test'
	],
	[
		['/test/route', ['/test']]
	],
	[
		[null, '/test']
	]
	],

	/**
	 * Single named parameter.
	 */
	[
	'/:test',
	null,
	[
		{
		name: 'test',
		prefix: '/',
		delimiter: '/',
		optional: false,
		repeat: false,
		partial: false,
		asterisk: false,
		pattern: '[^\\/]+?'
		}
	],
	[
		['/route', ['/route', 'route']],
		['/another', ['/another', 'another']],
		['/something/else', null],
		['/route.json', ['/route.json', 'route.json']],
		['/something%2Felse', ['/something%2Felse', 'something%2Felse']],
		['/something%2Felse%2Fmore', ['/something%2Felse%2Fmore', 'something%2Felse%2Fmore']],
		['/;,:@&=+$-_.!~*()', ['/;,:@&=+$-_.!~*()', ';,:@&=+$-_.!~*()']]
	],
	[
		[{ test: 'route' }, '/route'],
		[{ test: 'something/else' }, '/something%2Felse'],
		[{ test: 'something/else/more' }, '/something%2Felse%2Fmore']
	]
	],
	[
	'/:test',
	{
		strict: true
	},
	[
		{
		name: 'test',
		prefix: '/',
		delimiter: '/',
		optional: false,
		repeat: false,
		partial: false,
		asterisk: false,
		pattern: '[^\\/]+?'
		}
	],
	[
		['/route', ['/route', 'route']],
		['/route/', null]
	],
	[
		[{ test: 'route' }, '/route']
	]
	],
	[
	'/:test/',
	{
		strict: true
	},
	[
		{
		name: 'test',
		prefix: '/',
		delimiter: '/',
		optional: false,
		repeat: false,
		partial: false,
		asterisk: false,
		pattern: '[^\\/]+?'
		},
		'/'
	],
	[
		['/route/', ['/route/', 'route']],
		['/route//', null]
	],
	[
		[{ test: 'route' }, '/route/']
	]
	],
	[
	'/:test',
	{
		end: false
	},
	[
		{
		name: 'test',
		prefix: '/',
		delimiter: '/',
		optional: false,
		repeat: false,
		partial: false,
		asterisk: false,
		pattern: '[^\\/]+?'
		}
	],
	[
		['/route.json', ['/route.json', 'route.json']],
		['/route//', ['/route', 'route']]
	],
	[
		[{ test: 'route' }, '/route']
	]
	],

	/**
	 * Optional named parameter.
	 */
	[
	'/:test?',
	null,
	[
		{
		name: 'test',
		prefix: '/',
		delimiter: '/',
		optional: true,
		repeat: false,
		partial: false,
		asterisk: false,
		pattern: '[^\\/]+?'
		}
	],
	[
		['/route', ['/route', 'route']],
		['/route/nested', null],
		['/', ['/', null]],
		['//', null]
	],
	[
		[null, ''],
		[{ test: 'foobar' }, '/foobar']
	]
	],
	[
	'/:test?',
	{
		strict: true
	},
	[
		{
		name: 'test',
		prefix: '/',
		delimiter: '/',
		optional: true,
		repeat: false,
		partial: false,
		asterisk: false,
		pattern: '[^\\/]+?'
		}
	],
	[
		['/route', ['/route', 'route']],
		['/', null], // Questionable behaviour.
		['//', null]
	],
	[
		[null, ''],
		[{ test: 'foobar' }, '/foobar']
	]
	],
	[
	'/:test?/',
	{
		strict: true
	},
	[
		{
		name: 'test',
		prefix: '/',
		delimiter: '/',
		optional: true,
		repeat: false,
		partial: false,
		asterisk: false,
		pattern: '[^\\/]+?'
		},
		'/'
	],
	[
		['/route', null],
		['/route/', ['/route/', 'route']],
		['/', ['/', null]],
		['//', null]
	],
	[
		[null, '/'],
		[{ test: 'foobar' }, '/foobar/']
	]
	],
	[
	'/:test?/bar',
	null,
	[
		{
		name: 'test',
		prefix: '/',
		delimiter: '/',
		optional: true,
		repeat: false,
		partial: false,
		asterisk: false,
		pattern: '[^\\/]+?'
		},
		'/bar'
	],
	[
		['/foo/bar', ['/foo/bar', 'foo']]
	],
	[
		[{ test: 'foo' }, '/foo/bar']
	]
	],
	[
	'/:test?-bar',
	null,
	[
		{
		name: 'test',
		prefix: '/',
		delimiter: '/',
		optional: true,
		repeat: false,
		partial: true,
		asterisk: false,
		pattern: '[^\\/]+?'
		},
		'-bar'
	],
	[
		['/-bar', ['/-bar', null]],
		['/foo-bar', ['/foo-bar', 'foo']]
	],
	[
		[{ test: 'foo' }, '/foo-bar']
	]
	],

	/**
	 * Repeated one or more times parameters.
	 */
	[
	'/:test+',
	null,
	[
		{
		name: 'test',
		prefix: '/',
		delimiter: '/',
		optional: false,
		repeat: true,
		partial: false,
		asterisk: false,
		pattern: '[^\\/]+?'
		}
	],
	[
		['/', null],
		['/route', ['/route', 'route']],
		['/some/basic/route', ['/some/basic/route', 'some/basic/route']],
		['//', null]
	],
	[
		[{}, null],
		[{ test: 'foobar' }, '/foobar'],
		[{ test: ['a', 'b', 'c'] }, '/a/b/c']
	]
	],
	[
	'/:test(\\d+)+',
	null,
	[
		{
		name: 'test',
		prefix: '/',
		delimiter: '/',
		optional: false,
		repeat: true,
		partial: false,
		asterisk: false,
		pattern: '\\d+'
		}
	],
	[
		['/abc/456/789', null],
		['/123/456/789', ['/123/456/789', '123/456/789']]
	],
	[
		[{ test: 'abc' }, null],
		[{ test: '123' }, '/123'],
		[{ test: ['1', '2', '3'] }, '/1/2/3']
	]
	],
	[
	'/route.:ext(json|xml)+',
	null,
	[
		'/route',
		{
		name: 'ext',
		prefix: '.',
		delimiter: '.',
		optional: false,
		repeat: true,
		partial: false,
		asterisk: false,
		pattern: 'json|xml'
		}
	],
	[
		['/route', null],
		['/route.json', ['/route.json', 'json']],
		['/route.xml.json', ['/route.xml.json', 'xml.json']],
		['/route.html', null]
	],
	[
		[{ ext: 'foobar' }, null],
		[{ ext: 'xml' }, '/route.xml'],
		[{ ext: ['xml', 'json'] }, '/route.xml.json']
	]
	],

	/**
	 * Repeated zero or more times parameters.
	 */
	[
	'/:test*',
	null,
	[
		{
		name: 'test',
		prefix: '/',
		delimiter: '/',
		optional: true,
		repeat: true,
		partial: false,
		asterisk: false,
		pattern: '[^\\/]+?'
		}
	],
	[
		['/', ['/', null]],
		['//', null],
		['/route', ['/route', 'route']],
		['/some/basic/route', ['/some/basic/route', 'some/basic/route']]
	],
	[
		[{}, ''],
		[{ test: 'foobar' }, '/foobar'],
		[{ test: ['foo', 'bar'] }, '/foo/bar']
	]
	],
	[
	'/route.:ext([a-z]+)*',
	null,
	[
		'/route',
		{
		name: 'ext',
		prefix: '.',
		delimiter: '.',
		optional: true,
		repeat: true,
		partial: false,
		asterisk: false,
		pattern: '[a-z]+'
		}
	],
	[
		['/route', ['/route', null]],
		['/route.json', ['/route.json', 'json']],
		['/route.json.xml', ['/route.json.xml', 'json.xml']],
		['/route.123', null]
	],
	[
		[{}, '/route'],
		[{ ext: [] }, '/route'],
		[{ ext: '123' }, null],
		[{ ext: 'foobar' }, '/route.foobar'],
		[{ ext: ['foo', 'bar'] }, '/route.foo.bar']
	]
	],

	/**
	 * Custom named parameters.
	 */
	[
	'/:test(\\d+)',
	null,
	[
		{
		name: 'test',
		prefix: '/',
		delimiter: '/',
		optional: false,
		repeat: false,
		partial: false,
		asterisk: false,
		pattern: '\\d+'
		}
	],
	[
		['/123', ['/123', '123']],
		['/abc', null],
		['/123/abc', null]
	],
	[
		[{ test: 'abc' }, null],
		[{ test: '123' }, '/123']
	]
	],
	[
	'/:test(\\d+)',
	{
		end: false
	},
	[
		{
		name: 'test',
		prefix: '/',
		delimiter: '/',
		optional: false,
		repeat: false,
		partial: false,
		asterisk: false,
		pattern: '\\d+'
		}
	],
	[
		['/123', ['/123', '123']],
		['/abc', null],
		['/123/abc', ['/123', '123']]
	],
	[
		[{ test: '123' }, '/123']
	]
	],
	[
	'/:test(.*)',
	null,
	[
		{
		name: 'test',
		prefix: '/',
		delimiter: '/',
		optional: false,
		repeat: false,
		partial: false,
		asterisk: false,
		pattern: '.*'
		}
	],
	[
		['/anything/goes/here', ['/anything/goes/here', 'anything/goes/here']],
		['/;,:@&=/+$-_.!/~*()', ['/;,:@&=/+$-_.!/~*()', ';,:@&=/+$-_.!/~*()']]
	],
	[
		[{ test: '' }, '/'],
		[{ test: 'abc' }, '/abc'],
		[{ test: 'abc/123' }, '/abc%2F123'],
		[{ test: 'abc/123/456' }, '/abc%2F123%2F456']
	]
	],
	[
	'/:route([a-z]+)',
	null,
	[
		{
		name: 'route',
		prefix: '/',
		delimiter: '/',
		optional: false,
		repeat: false,
		partial: false,
		asterisk: false,
		pattern: '[a-z]+'
		}
	],
	[
		['/abcde', ['/abcde', 'abcde']],
		['/12345', null]
	],
	[
		[{ route: '' }, null],
		[{ route: '123' }, null],
		[{ route: 'abc' }, '/abc']
	]
	],
	[
	'/:route(this|that)',
	null,
	[
		{
		name: 'route',
		prefix: '/',
		delimiter: '/',
		optional: false,
		repeat: false,
		partial: false,
		asterisk: false,
		pattern: 'this|that'
		}
	],
	[
		['/this', ['/this', 'this']],
		['/that', ['/that', 'that']],
		['/foo', null]
	],
	[
		[{ route: 'this' }, '/this'],
		[{ route: 'foo' }, null],
		[{ route: 'that' }, '/that']
	]
	],
	[
	'/:path(abc|xyz)*',
	null,
	[
		{
		name: 'path',
		prefix: '/',
		delimiter: '/',
		optional: true,
		repeat: true,
		partial: false,
		asterisk: false,
		pattern: 'abc|xyz'
		}
	],
	[
		['/abc', ['/abc', 'abc']],
		['/abc/abc', ['/abc/abc', 'abc/abc']],
		['/xyz/xyz', ['/xyz/xyz', 'xyz/xyz']],
		['/abc/xyz', ['/abc/xyz', 'abc/xyz']],
		['/abc/xyz/abc/xyz', ['/abc/xyz/abc/xyz', 'abc/xyz/abc/xyz']],
		['/xyzxyz', null]
	],
	[
		[{ path: 'abc' }, '/abc'],
		[{ path: ['abc', 'xyz'] }, '/abc/xyz'],
		[{ path: ['xyz', 'abc', 'xyz'] }, '/xyz/abc/xyz'],
		[{ path: 'abc123' }, null],
		[{ path: 'abcxyz' }, null]
	]
	],

	/**
	 * Prefixed slashes could be omitted.
	 */
	[
	'test',
	null,
	[
		'test'
	],
	[
		['test', ['test']],
		['/test', null]
	],
	[
		[null, 'test']
	]
	],
	[
	':test',
	null,
	[
		{
		name: 'test',
		prefix: '',
		delimiter: '/',
		optional: false,
		repeat: false,
		partial: false,
		asterisk: false,
		pattern: '[^\\/]+?'
		}
	],
	[
		['route', ['route', 'route']],
		['/route', null],
		['route/', ['route/', 'route']]
	],
	[
		[{ test: '' }, null],
		[{}, null],
		[{ test: null }, null],
		[{ test: 'route' }, 'route']
	]
	],
	[
	':test',
	{
		strict: true
	},
	[
		{
		name: 'test',
		prefix: '',
		delimiter: '/',
		optional: false,
		repeat: false,
		partial: false,
		asterisk: false,
		pattern: '[^\\/]+?'
		}
	],
	[
		['route', ['route', 'route']],
		['/route', null],
		['route/', null]
	],
	[
		[{ test: 'route' }, 'route']
	]
	],
	[
	':test',
	{
		end: false
	},
	[
		{
		name: 'test',
		prefix: '',
		delimiter: '/',
		optional: false,
		repeat: false,
		partial: false,
		asterisk: false,
		pattern: '[^\\/]+?'
		}
	],
	[
		['route', ['route', 'route']],
		['/route', null],
		['route/', ['route/', 'route']],
		['route/foobar', ['route', 'route']]
	],
	[
		[{ test: 'route' }, 'route']
	]
	],
	[
	':test?',
	null,
	[
		{
		name: 'test',
		prefix: '',
		delimiter: '/',
		optional: true,
		repeat: false,
		partial: false,
		asterisk: false,
		pattern: '[^\\/]+?'
		}
	],
	[
		['route', ['route', 'route']],
		['/route', null],
		['', ['', null]],
		['route/foobar', null]
	],
	[
		[{}, ''],
		[{ test: '' }, null],
		[{ test: 'route' }, 'route']
	]
	],

	/**
	 * Formats.
	 */
	[
	'/test.json',
	null,
	[
		'/test.json'
	],
	[
		['/test.json', ['/test.json']],
		['/route.json', null]
	],
	[
		[{}, '/test.json']
	]
	],
	[
	'/:test.json',
	null,
	[
		{
		name: 'test',
		prefix: '/',
		delimiter: '/',
		optional: false,
		repeat: false,
		partial: true,
		asterisk: false,
		pattern: '[^\\/]+?'
		},
		'.json'
	],
	[
		['/.json', null],
		['/test.json', ['/test.json', 'test']],
		['/route.json', ['/route.json', 'route']],
		['/route.json.json', ['/route.json.json', 'route.json']]
	],
	[
		[{ test: '' }, null],
		[{ test: 'foo' }, '/foo.json']
	]
	],

	/**
	 * Format params.
	 */
	[
	'/test.:format',
	null,
	[
		'/test',
		{
		name: 'format',
		prefix: '.',
		delimiter: '.',
		optional: false,
		repeat: false,
		partial: false,
		asterisk: false,
		pattern: '[^.]+?'
		}
	],
	[
		['/test.html', ['/test.html', 'html']],
		['/test.hbs.html', null]
	],
	[
		[{}, null],
		[{ format: '' }, null],
		[{ format: 'foo' }, '/test.foo']
	]
	],
	[
	'/test.:format.:format',
	null,
	[
		'/test',
		{
		name: 'format',
		prefix: '.',
		delimiter: '.',
		optional: false,
		repeat: false,
		partial: false,
		asterisk: false,
		pattern: '[^.]+?'
		},
		{
		name: 'format',
		prefix: '.',
		delimiter: '.',
		optional: false,
		repeat: false,
		partial: false,
		asterisk: false,
		pattern: '[^.]+?'
		}
	],
	[
		['/test.html', null],
		['/test.hbs.html', ['/test.hbs.html', 'hbs', 'html']]
	],
	[
		[{ format: 'foo.bar' }, null],
		[{ format: 'foo' }, '/test.foo.foo']
	]
	],
	[
	'/test.:format+',
	null,
	[
		'/test',
		{
		name: 'format',
		prefix: '.',
		delimiter: '.',
		optional: false,
		repeat: true,
		partial: false,
		asterisk: false,
		pattern: '[^.]+?'
		}
	],
	[
		['/test.html', ['/test.html', 'html']],
		['/test.hbs.html', ['/test.hbs.html', 'hbs.html']]
	],
	[
		[{ format: [] }, null],
		[{ format: 'foo' }, '/test.foo'],
		[{ format: ['foo', 'bar'] }, '/test.foo.bar']
	]
	],
	[
	'/test.:format',
	{
		end: false
	},
	[
		'/test',
		{
		name: 'format',
		prefix: '.',
		delimiter: '.',
		optional: false,
		repeat: false,
		partial: false,
		asterisk: false,
		pattern: '[^.]+?'
		}
	],
	[
		['/test.html', ['/test.html', 'html']],
		['/test.hbs.html', null]
	],
	[
		[{ format: 'foo' }, '/test.foo']
	]
	],
	[
	'/test.:format.',
	null,
	[
		'/test',
		{
		name: 'format',
		prefix: '.',
		delimiter: '.',
		optional: false,
		repeat: false,
		partial: false,
		asterisk: false,
		pattern: '[^.]+?'
		},
		'.'
	],
	[
		['/test.html.', ['/test.html.', 'html']],
		['/test.hbs.html', null]
	],
	[
		[{ format: '' }, null],
		[{ format: 'foo' }, '/test.foo.']
	]
	],

	/**
	 * Format and path params.
	 */
	[
	'/:test.:format',
	null,
	[
		{
		name: 'test',
		prefix: '/',
		delimiter: '/',
		optional: false,
		repeat: false,
		partial: true,
		asterisk: false,
		pattern: '[^\\/]+?'
		},
		{
		name: 'format',
		prefix: '.',
		delimiter: '.',
		optional: false,
		repeat: false,
		partial: false,
		asterisk: false,
		pattern: '[^.]+?'
		}
	],
	[
		['/route.html', ['/route.html', 'route', 'html']],
		['/route', null],
		['/route.html.json', ['/route.html.json', 'route.html', 'json']]
	],
	[
		[{}, null],
		[{ test: 'route', format: 'foo' }, '/route.foo']
	]
	],
	[
	'/:test.:format?',
	null,
	[
		{
		name: 'test',
		prefix: '/',
		delimiter: '/',
		optional: false,
		repeat: false,
		partial: true,
		asterisk: false,
		pattern: '[^\\/]+?'
		},
		{
		name: 'format',
		prefix: '.',
		delimiter: '.',
		optional: true,
		repeat: false,
		partial: false,
		asterisk: false,
		pattern: '[^.]+?'
		}
	],
	[
		['/route', ['/route', 'route', null]],
		['/route.json', ['/route.json', 'route', 'json']],
		['/route.json.html', ['/route.json.html', 'route.json', 'html']]
	],
	[
		[{ test: 'route' }, '/route'],
		[{ test: 'route', format: '' }, null],
		[{ test: 'route', format: 'foo' }, '/route.foo']
	]
	],
	[
	'/:test.:format?',
	{
		end: false
	},
	[
		{
		name: 'test',
		prefix: '/',
		delimiter: '/',
		optional: false,
		repeat: false,
		partial: true,
		asterisk: false,
		pattern: '[^\\/]+?'
		},
		{
		name: 'format',
		prefix: '.',
		delimiter: '.',
		optional: true,
		repeat: false,
		partial: false,
		asterisk: false,
		pattern: '[^.]+?'
		}
	],
	[
		['/route', ['/route', 'route', null]],
		['/route.json', ['/route.json', 'route', 'json']],
		['/route.json.html', ['/route.json.html', 'route.json', 'html']]
	],
	[
		[{ test: 'route' }, '/route'],
		[{ test: 'route', format: null }, '/route'],
		[{ test: 'route', format: '' }, null],
		[{ test: 'route', format: 'foo' }, '/route.foo']
	]
	],
	[
	'/test.:format(.*)z',
	{
		end: false
	},
	[
		'/test',
		{
		name: 'format',
		prefix: '.',
		delimiter: '.',
		optional: false,
		repeat: false,
		partial: true,
		asterisk: false,
		pattern: '.*'
		},
		'z'
	],
	[
		['/test.abc', null],
		['/test.z', ['/test.z', '']],
		['/test.abcz', ['/test.abcz', 'abc']]
	],
	[
		[{}, null],
		[{ format: '' }, '/test.z'],
		[{ format: 'foo' }, '/test.fooz']
	]
	],

	/**
	 * Unnamed params.
	 */
	[
	'/(\\d+)',
	null,
	[
		{
		name: '0',
		prefix: '/',
		delimiter: '/',
		optional: false,
		repeat: false,
		partial: false,
		asterisk: false,
		pattern: '\\d+'
		}
	],
	[
		['/123', ['/123', '123']],
		['/abc', null],
		['/123/abc', null]
	],
	[
		[{}, null],
		[{ '0': '123' }, '/123']
	]
	],
	[
	'/(\\d+)',
	{
		end: false
	},
	[
		{
		name: '0',
		prefix: '/',
		delimiter: '/',
		optional: false,
		repeat: false,
		partial: false,
		asterisk: false,
		pattern: '\\d+'
		}
	],
	[
		['/123', ['/123', '123']],
		['/abc', null],
		['/123/abc', ['/123', '123']],
		['/123/', ['/123/', '123']]
	],
	[
		[{ '0': '123' }, '/123']
	]
	],
	[
	'/(\\d+)?',
	null,
	[
		{
		name: '0',
		prefix: '/',
		delimiter: '/',
		optional: true,
		repeat: false,
		partial: false,
		asterisk: false,
		pattern: '\\d+'
		}
	],
	[
		['/', ['/', null]],
		['/123', ['/123', '123']]
	],
	[
		[{}, ''],
		[{ '0': '123' }, '/123']
	]
	],
	[
	'/(.*)',
	null,
	[
		{
		name: '0',
		prefix: '/',
		delimiter: '/',
		optional: false,
		repeat: false,
		partial: false,
		asterisk: false,
		pattern: '.*'
		}
	],
	[
		['/', ['/', '']],
		['/route', ['/route', 'route']],
		['/route/nested', ['/route/nested', 'route/nested']]
	],
	[
		[{ '0': '' }, '/'],
		[{ '0': '123' }, '/123']
	]
	],
	[
	'/route\\(\\\\(\\d+\\\\)\\)',
	 null,
	[
		'/route(\\',
		{
		name: '0',
		prefix: '',
		delimiter: '/',
		optional: false,
		repeat: false,
		partial: false,
		asterisk: false,
		pattern: '\\d+\\\\'
		},
		')'
	],
	[
		['/route(\\123\\)', ['/route(\\123\\)', '123\\']]
	],
	[]
	],

	/**
	 * Respect escaped characters.
	 */
	[
	'/\\(testing\\)',
	null,
	[
		'/(testing)'
	],
	[
		['/testing', null],
		['/(testing)', ['/(testing)']]
	],
	[
		[null, '/(testing)']
	]
	],
	[
	"/.+\\*?=^!:${}[]|",
	null,
	[
		"/.+*?=^!:${}[]|"
	],
	[
		["/.+*?=^!:${}[]|", ["/.+*?=^!:${}[]|"]]
	],
	[
		[null, "/.+*?=^!:${}[]|"]
	]
	],

	/**
	 * Asterisk functionality.
	 */
	[
	'/*',
	null,
	[
		{
		name: '0',
		prefix: '/',
		delimiter: '/',
		optional: false,
		repeat: false,
		partial: false,
		asterisk: true,
		pattern: '.*'
		}
	],
	[
		['', null],
		['/', ['/', '']],
		['/foo/bar', ['/foo/bar', 'foo/bar']]
	],
	[
		[null, null],
		[{ '0': '' }, '/'],
		[{ '0': 'foobar' }, '/foobar'],
		[{ '0': 'foo/bar' }, '/foo/bar'],
		[{ '0': ['foo', 'bar'] }, null],
		[{ '0': 'foo/bar?baz' }, '/foo/bar%3Fbaz']
	]
	],
	[
	'/foo/*',
	null,
	[
		'/foo',
		{
		name: '0',
		prefix: '/',
		delimiter: '/',
		optional: false,
		repeat: false,
		partial: false,
		asterisk: true,
		pattern: '.*'
		}
	],
	[
		['', null],
		['/test', null],
		['/foo', null],
		['/foo/', ['/foo/', '']],
		['/foo/bar', ['/foo/bar', 'bar']]
	],
	[
		[{ '0': 'bar' }, '/foo/bar']
	]
	],
	[
	'/:foo/*',
	null,
	[
		{
		name: 'foo',
		prefix: '/',
		delimiter: '/',
		optional: false,
		repeat: false,
		partial: false,
		asterisk: false,
		pattern: '[^\\/]+?'
		},
		{
		name: '0',
		prefix: '/',
		delimiter: '/',
		optional: false,
		repeat: false,
		partial: false,
		asterisk: true,
		pattern: '.*'
		}
	],
	[
		['', null],
		['/test', null],
		['/foo', null],
		['/foo/', ['/foo/', 'foo', '']],
		['/foo/bar', ['/foo/bar', 'foo', 'bar']]
	],
	[
		[{ foo: 'foo' }, null],
		[{ '0': 'bar' }, null],
		[{ foo: 'foo', '0': 'bar' }, '/foo/bar'],
		[{ foo: 'a', '0': 'b/c' }, '/a/b/c']
	]
	],

	/**
	 * Unnamed group prefix.
	 */
	[
	'/(apple-)?icon-:res(\\d+).png',
	null,
	[
		{
		name: '0',
		prefix: '/',
		delimiter: '/',
		optional: true,
		repeat: false,
		partial: true,
		asterisk: false,
		pattern: 'apple-'
		},
		'icon-',
		{
		name: 'res',
		prefix: '',
		delimiter: '/',
		optional: false,
		repeat: false,
		partial: false,
		asterisk: false,
		pattern: '\\d+'
		},
		'.png'
	],
	[
		['/icon-240.png', ['/icon-240.png', null, '240']],
		['/apple-icon-240.png', ['/apple-icon-240.png', 'apple-', '240']]
	],
	[]
	],

	/**
	 * Random examples.
	 */
	[
	'/:foo/:bar',
	null,
	[
		{
		name: 'foo',
		prefix: '/',
		delimiter: '/',
		optional: false,
		repeat: false,
		partial: false,
		asterisk: false,
		pattern: '[^\\/]+?'
		},
		{
		name: 'bar',
		prefix: '/',
		delimiter: '/',
		optional: false,
		repeat: false,
		partial: false,
		asterisk: false,
		pattern: '[^\\/]+?'
		}
	],
	[
		['/match/route', ['/match/route', 'match', 'route']]
	],
	[
		[{ foo: 'a', bar: 'b' }, '/a/b']
	]
	],
	[
	'/:foo(test\\)/bar',
	null,
	[
		{
		name: 'foo',
		prefix: '/',
		delimiter: '/',
		optional: false,
		repeat: false,
		partial: true,
		asterisk: false,
		pattern: '[^\\/]+?'
		},
		'(test)/bar'
	],
	[],
	[]
	],
	[
	'/:remote([\\w-.]+)/:user([\\w-]+)',
	null,
	[
		{
		name: 'remote',
		prefix: '/',
		delimiter: '/',
		optional: false,
		repeat: false,
		partial: false,
		asterisk: false,
		pattern: '[\\w-.]+'
		},
		{
		name: 'user',
		prefix: '/',
		delimiter: '/',
		optional: false,
		repeat: false,
		partial: false,
		asterisk: false,
		pattern: '[\\w-]+'
		}
	],
	[
		['/endpoint/user', ['/endpoint/user', 'endpoint', 'user']],
		['/endpoint/user-name', ['/endpoint/user-name', 'endpoint', 'user-name']],
		['/foo.bar/user-name', ['/foo.bar/user-name', 'foo.bar', 'user-name']]
	],
	[
		[{ remote: 'foo', user: 'bar' }, '/foo/bar'],
		[{ remote: 'foo.bar', user: 'uno' }, '/foo.bar/uno']
	]
	],
	[
	'/:foo\\?',
	null,
	[
		{
		name: 'foo',
		prefix: '/',
		delimiter: '/',
		optional: false,
		repeat: false,
		partial: true,
		asterisk: false,
		pattern: '[^\\/]+?'
		},
		'?'
	],
	[
		['/route?', ['/route?', 'route']]
	],
	[
		[{ foo: 'bar' }, '/bar?']
	]
	],
	[
	'/:foo+baz',
	null,
	[
		{
		name: 'foo',
		prefix: '/',
		delimiter: '/',
		optional: false,
		repeat: true,
		partial: true,
		asterisk: false,
		pattern: '[^\\/]+?'
		},
		'baz'
	],
	[
		['/foobaz', ['/foobaz', 'foo']],
		['/foo/barbaz', ['/foo/barbaz', 'foo/bar']],
		['/baz', null]
	],
	[
		[{ foo: 'foo' }, '/foobaz'],
		[{ foo: 'foo/bar' }, '/foo%2Fbarbaz'],
		[{ foo: ['foo', 'bar'] }, '/foo/barbaz']
	]
	],
	[
	'/:pre?baz',
	null,
	[
		{
		name: 'pre',
		prefix: '/',
		delimiter: '/',
		optional: true,
		repeat: false,
		partial: true,
		asterisk: false,
		pattern: '[^\\/]+?'
		},
		'baz'
	],
	[
		['/foobaz', ['/foobaz', 'foo']],
		['/baz', ['/baz', null]]
	],
	[
		[{}, '/baz'],
		[{ pre: 'foo' }, '/foobaz']
	]
	],
	[
	'/:foo\\(:bar?\\)',
	null,
	[
		{
		name: 'foo',
		prefix: '/',
		delimiter: '/',
		optional: false,
		repeat: false,
		partial: true,
		asterisk: false,
		pattern: '[^\\/]+?'
		},
		'(',
		{
		name: 'bar',
		prefix: '',
		delimiter: '/',
		optional: true,
		repeat: false,
		partial: false,
		asterisk: false,
		pattern: '[^\\/]+?'
		},
		')'
	],
	[
		['/hello(world)', ['/hello(world)', 'hello', 'world']],
		['/hello()', ['/hello()', 'hello', null]]
	],
	[
		[{ foo: 'hello', bar: 'world' }, '/hello(world)'],
		[{ foo: 'hello' }, '/hello()']
	]
	],
	[
	'/:postType(video|audio|text)(\\+.+)?',
	null,
	[
		{
		name: 'postType',
		prefix: '/',
		delimiter: '/',
		optional: false,
		repeat: false,
		partial: true,
		asterisk: false,
		pattern: 'video|audio|text'
		},
		{
		name: '0',
		prefix: '',
		delimiter: '/',
		optional: true,
		repeat: false,
		partial: false,
		asterisk: false,
		pattern: '\\+.+'
		}
	],
	[
		['/video', ['/video', 'video', null]],
		['/video+test', ['/video+test', 'video', '+test']],
		['/video+', null]
	],
	[
		[{ postType: 'video' }, '/video'],
		[{ postType: 'random' }, null]
	]
	],

	/**
	 * Unicode characters.
	 */
	[
	'/:foo',
	null,
	[
		{
		name: 'foo',
		prefix: '/',
		delimiter: '/',
		optional: false,
		repeat: false,
		partial: false,
		asterisk: false,
		pattern: '[^\\/]+?'
		}
	],
	[
		['/café', ['/café', 'café']]
	],
	[
		[{ foo: 'café' }, '/caf%C3%A9']
	]
	]
];