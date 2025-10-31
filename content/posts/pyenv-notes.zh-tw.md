---
title: "Pyenv Notes"
date: 2021-11-01T18:48:33+08:00
categories:
- Develop environment
tags: [Programming, Python, Pyenv]
slug: 'pyenv-notes'
---
### `pyenv` 的功能和使用的原因

`pyenv` 是用來在系統裡安裝各種不同版本的 python，

並能夠方便的切換 python 版本的工具。

當同時有不同 python 版本的專案需要開發或維護時，

就會需要使用 `pyenv` 來協助切換 python 的版本。

python 的新版本通常都會有一些語法上的更新或是新增一些功能，

例如 python 的 `async / await` 就是 python 3.5 以上才出現的功能，

用 python 3.5 以下的版本來開發的專案就無法使用；

又或者例如同時有 python 2 和 python 3 的專案，

而且因為 python 2 和 python 3 語法不相容，

勢必要在系統裡安裝 python 2 和 python 3；

諸如次類的情況就可以使用 `pyenv` 方便的切換 python 的版本。

### 安裝和初始化

安裝

```bash
brew install pyenv
```

安裝完畢後執行初始化

```bash
pyenv init
```

之後按照指示將顯示的 code 貼到 `~/.zshrc` 或 `~/.bash_profile`

### 常用指令

- 列出可以安裝的 python 版本

```bash
pyenv install --list
```

會出現

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

- 安裝指定版本的 python

```bash
pyenv install 3.10.0
```

- 觀察已經安裝過哪些版本的 python

```bash
pyenv versions
```

會出現

```
* system (set by ......./.pyenv/version)
  3.10.0
```

代表目前有系統預設的版本跟剛剛安裝過的 `3.10.0`，

但目前使用 python 的是系統預設版本

- 切換系統使用版本

```bash
pyenv global 3.10.0
```

到系統任何地方下 `pyenv versions` 都會看到目前使用的 python 版本是 `3.10.0`

- 只切換**當前目錄下**的 python 版本

```bash
pyenv local 3.7.12
```

在當前目錄下 `pyenv versions` 會看到正在使用的是 `3.7.12` 的版本；

但是到其他目錄下，

假如之前有用 `pyenv global` 設定過版本 (假設是 `3.10.0`)， 

則 `pyenv versions` 會看到的是之前用 `pyenv global` 設定的版本 (`3.10.0`)；

假如沒有跑過 `pyenv global` 設定版本則 `pyenv versions` 會出現系統預設的版本。

- 解除安裝指定的 python 版本

```bash
pyenv uninstall 3.7.12
```

## Reference

[pyenv Github](https://github.com/pyenv/pyenv)
