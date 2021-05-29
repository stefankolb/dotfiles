# Stefan's dotfiles

These are *my* personal dotfiles. Use at your own risk!

Just started working on this, so don't expect anything...


# Installation

To install/setup these dotfiles, you can runuse the [install script][1] via cURL:

```sh
curl -o- https://raw.githubusercontent.com/stefankolb/dotfiles/master/install.sh | bash
```

**NOTE**: Currently, this will override any existing dotfiles, so be careful!


# Noteworthy

## `.eslintrc`

I've been using [JSHint][100] for quite some time, but recently
switched to [ESLint][101]. The ESLint runtime configuration in
[`.eslintrc-all`][103] holds
all available rules for the version mentioned below. All checks are deactived by default and can be activated on a per project base. I use [`.eslintrc`][104] during development and [`.eslintrc-commit`][105] is used in Git pre-commit.

* ESLint: v7.27.0 ([list of rules][102])
* Last checked: 2020-05-29


# Credits

I learned a lot from - and was inspired by - the dotfiles of other people, in
particular (in alphabetical order):

* [Matthias Bynens' dotfiles][107]
* [Mina Markham's formation][109]
* [Nick S. Plekhanov's dotfiles][108]
* [Paul Irish's dotfiles][106]


# ToDos

* Write README.md
  * Add credits
* Write install script
* Write update script


[//]: # "References"

[1]: https://github.com/stefankolb/dotfiles/blob/master/install.sh
[100]: http://jshint.com
[101]: http://eslint.org
[102]: http://eslint.org/docs/rules/
[103]: https://github.com/stefankolb/dotfiles/blob/master/coding/.eslintrc-all
[104]: https://github.com/stefankolb/dotfiles/blob/master/coding/.eslintrc
[105]: https://github.com/stefankolb/dotfiles/blob/master/coding/.eslintrc-commit
[106]: https://github.com/paulirish/dotfiles
[107]: https://github.com/mathiasbynens/dotfiles
[108]: https://github.com/nicksp/dotfiles
[109]: https://github.com/minamarkham/formation
