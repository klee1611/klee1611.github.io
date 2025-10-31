---
title: "Pyenv Notes"
date: 2021-11-01T18:48:33+08:00
categories:
- Develop environment
tags: [Programming, Python, Pyenv]
slug: 'pyenv-notes'
---
### Functions and Reasons for Using `pyenv`

`pyenv` is a tool used to install various versions of Python on a system,

and to conveniently switch between Python versions.

When you need to develop or maintain projects that require different Python versions simultaneously,

you will need to use `pyenv` to help switch Python versions.

New Python versions usually include syntax updates or new features.

For example, Python's `async / await` feature appeared only in Python 3.5 and later.

Projects developed with Python versions below 3.5 cannot use it.

Another example is having projects that use both Python 2 and Python 3.

Since Python 2 and Python 3 are syntactically incompatible,

it is necessary to install both Python 2 and Python 3 on the system.

In such cases, `pyenv` can be used to conveniently switch Python versions.

### Installation and Initialization

Installation

```bash
brew install pyenv
```

After installation, run initialization

```bash
pyenv init
```

Then, follow the instructions to paste the displayed code into `~/.zshrc` or `~/.bash_profile`

### Common Commands

- List available Python versions for installation

```bash
pyenv install --list
```

This will show:

```
Available versions:
  2.1.3
  2.2.3
  2.3.7
  2.4.0
	...
  3.9.6
  3.9.7
  3.10.0
  3.10-dev
  3.11.0a1
	...
```

- Install a specific Python version

```bash
pyenv install 3.10.0
```

- Observe which Python versions have been installed

```bash
pyenv versions
```

This will show:

```
* system (set by ......./.pyenv/version)
  3.10.0
```

This indicates that the system's default version and the recently installed `3.10.0` are available,

but the currently used Python version is the system's default.

- Switch the system-wide Python version

```bash
pyenv global 3.10.0
```

Running `pyenv versions` anywhere in the system will show that the currently used Python version is `3.10.0`.

- Switch the Python version **only for the current directory**

```bash
pyenv local 3.7.12
```

In the current directory, `pyenv versions` will show that version `3.7.12` is being used.

However, in other directories,

if a version was previously set using `pyenv global` (e.g., `3.10.0`),

then `pyenv versions` will show the version set by `pyenv global` (`3.10.0`).

If `pyenv global` was not run to set a version, `pyenv versions` will show the system's default version.

- Uninstall a specific Python version

```bash
pyenv uninstall 3.7.12
```

## Reference

[pyenv Github](https://github.com/pyenv/pyenv)
