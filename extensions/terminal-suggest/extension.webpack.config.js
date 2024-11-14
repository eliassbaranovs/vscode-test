/*---------------------------------------------------------------------------------------------
 *  Copyright (c) Microsoft Corporation. All rights reserved.
 *  Licensed under the MIT License. See License.txt in the project root for license information.
 *--------------------------------------------------------------------------------------------*/

//@ts-check
'use strict';

const path = require('path');
const withDefaults = require('../shared.webpack.config');
const webpack = require('webpack');

module.exports = withDefaults({
	context: __dirname,
	entry: {
		extension: './src/terminalSuggestMain.ts',
	},
	output: {
		filename: 'terminalSuggestMain.js',
	},
	resolve: {
		mainFields: ['module', 'main'],
		extensions: ['.ts', '.js'] // support ts-files and js-files
	}
});
