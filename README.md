# Stefan's dotfiles

These are *my* personal dotfiles. Use at your own risk! 

Just started working on this, so don't expect anything...

# Noteworthy

## `.eslintrc`

I've been using [JSHint](http://jshint.com) for quite some time, but recently 
switched to [ESLint](http://eslint.org). The ESLint runtime configuration in
[`.eslintrc`](https://github.com/stefankolb/dotfiles/blob/master/.eslintrc) holds 
all available rules for the version mentioned below. The ruleset is rather 
strict for now, don't know if this is a good thing or not.

> **Note**: Rules for Node.js, CommonJS and ECMAScript 6 are disabled.

* ESLint: v3.3.1 ([list of rules](http://eslint.org/docs/rules/))
* Last checked: 2016-08-24


# Credits

* [Paul Irish's dotfiles](https://github.com/paulirish/dotfiles)
* [Matthias' Bynens dotfiles](https://github.com/mathiasbynens/dotfiles)

# ToDos
 * Create main Gruntfile
 * Create folder with grunt files/tasks
 * Add grunt task for copying .dotfiles to user directory
 * Add grunt task for symlinking all files
 * Add grunt task to add bin to $PATH
 * Write README.md
 
