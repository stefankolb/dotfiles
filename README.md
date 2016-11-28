# Stefan's dotfiles

These are *my* personal dotfiles. Use at your own risk! 

Just started working on this, so don't expect anything...

# Noteworthy

## `.eslintrc`

I've been using [JSHint][1] for quite some time, but recently 
switched to [ESLint][2]. The ESLint runtime configuration in
[`.eslintrc`][4] holds 
all available rules for the version mentioned below. The ruleset is rather 
strict for now, don't know if this is a good thing or not.

> **Note**: Rules for Node.js, CommonJS and ECMAScript 6 are disabled.

* ESLint: v3.11.0 ([list of rules][3]
* Last checked: 2016-11-28


# Credits

I learned a lot from - and was inspired by - the dotfiles of other people, in
particular (in alphabetical order):

* [Matthias Bynens' dotfiles][6]
* [Nick S. Plekhanov's dotfiles][7]
* [Paul Irish's dotfiles][5]


# ToDos
 * Create main Gruntfile
 * Create folder with grunt files/tasks
 * Add grunt task for copying .dotfiles to user directory
 * Add grunt task for symlinking all files
 * Add grunt task to add bin to $PATH
 * Write README.md
 

[//]: # "References"

[1]: http://jshint.com
[2]: http://eslint.org
[3]: http://eslint.org/docs/rules/
[4]: https://github.com/stefankolb/dotfiles/blob/master/.eslintrc
[5]: https://github.com/paulirish/dotfiles
[6]: https://github.com/mathiasbynens/dotfiles
[7]: https://github.com/nicksp/dotfiles
