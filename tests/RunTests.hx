package tests;

import path2ereg.Path2EReg;
import path2ereg.Path2EReg.*;
import tests.TestCases.tests;

final TestSuite = suite(test -> {
	for (row in tests) {
		var path = row[0];
		test('path $path', () -> {
			var opts = row[1];
			var tokens: Array<Dynamic> = row[2];
			var matchCases = row[3];
			var compileCases: Array<Dynamic> = row[4];

			var keys: Array<Key> = cast tokens.filter(function (token)
				return Std.isOfType(token, String)
			);

			var re = toEReg(path, opts);
			
			var parsed = parse(path);
			for (i in 0 ... parsed.length) {
				switch parsed[i] {
					case Static(token): 
						assert.is(token, tokens[i]);
					case Capture(token):
						assert.equal(token, tokens[i]);
				}
			}

			var toPath = compile(path);

			for (io in compileCases) {
				var input = io[0];
				var output = io[1];

				if (output != null) {
					if (input == null) input = {};
					assert.equal(output, toPath(input));
				} else {
					assert.throws(() -> toPath(input));
				}
			}
		});
	}
});
