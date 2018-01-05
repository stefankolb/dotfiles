# Stefan's dotfiles

These are *my* personal dotfiles. Use at your own risk!

Just started working on this, so don't expect anything...

# Noteworthy

## `.eslintrc`

I've been using [JSHint][1] for quite some time, but recently
switched to [ESLint][2]. The ESLint runtime configuration in
[`.eslintrc-all`][4] holds
all available rules for the version mentioned below. All checks are deactived by default and can be activated on a per project base. I use [`.eslintrc`][5] during development and [`.eslintrc-commit`][5] is used in Git pre-commit.

* ESLint: v4.14.0 ([list of rules][3])
* Last checked: 2018-01-05


# Credits

I learned a lot from - and was inspired by - the dotfiles of other people, in
particular (in alphabetical order):

* [Matthias Bynens' dotfiles][8]
* [Nick S. Plekhanov's dotfiles][9]
* [Paul Irish's dotfiles][7]


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
[4]: https://github.com/stefankolb/dotfiles/blob/master/coding/.eslintrc-all
[5]: https://github.com/stefankolb/dotfiles/blob/master/coding/.eslintrc
[6]: https://github.com/stefankolb/dotfiles/blob/master/coding/.eslintrc-commit
[7]: https://github.com/paulirish/dotfiles
[8]: https://github.com/mathiasbynens/dotfiles
[9]: https://github.com/nicksp/dotfiles
