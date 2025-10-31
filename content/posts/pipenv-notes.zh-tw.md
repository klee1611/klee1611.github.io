---
title: "Pipenv Notes"
date: 2021-09-26T18:34:23+08:00
categories:
- Develop environment
tags: [Programming, Python, Pipenv]
slug: 'pipenv-notes'
---
## Why Pipenv
當有很多 Python project 要維護，  
不同的 project 有可能使用相同的 python libraries 的不同版本，  
不使用 virtual environment 而將所有的 python modules 都裝在自己的機器上就會造成版本衝突。  

過去使用 `virtualenv` + `requirement.txt` 的機制可以在不同的 project 使用同一個套件的不同版本，  
也能夠讓新加入的開發者或 production 環境可以快速安裝 project 需要的套件，  
<!--more-->
但當套件需要更新時相當麻煩，  
需要手動再去倒出一份新的 `requirement.txt`，  
而且當 project 有不同環境的需求的時候(例如 development 環境和 production 環境)還要維護`requirement-prod.txt` 和 `requirement-dev.txt` 兩份套件設定，  
如果不搭配 `pyenv` 也無法切換不同的 python 版本。  

後來發現了 Python 官方推薦的 `pipenv` 解決了這些問題，  
可以方便的只用 command 做到：  
- 建立獨立的 python 版本和套件虛擬環境
- 安裝並記錄套件版本到自動生成的 `Pipfile` 和 `Pipfile.lock`，同時透過套件的 Hash 值檢查套件安全性
- 紀錄套件使用環境 (分開 development 和 production 環境)
- 讀取 `.env` 檔案設定虛擬環境的環境變數
- 自動切換系統中的 python 版本（或 `pyenv` 有安裝的 python 版本）

## 操作 Pipenv
### Install Pipenv

```bash
pip3 install pipenv
```

### Pipenv Commands

- 建立特定 python 版本的獨立虛擬環境:

    到 project 所在的目錄下
    ```bash
    pipenv --python 3.8
    ```
    - 注意該版本的 python 系統要有，不然就要用 `pyenv` 裝一下

- 安裝套件
    ```bash
    pipenv install flask
    ```

- 安裝 development 套件

    加上 `--dev` 的套件在自動生成的 `Pipfile` 中會被放到 `[dev-packages]` 底下
    ```bash
    pipenv install pytest --dev
    ```

- 移除套件
    ```bash
    pipenv uninstall flask
    ```

- 在建立的虛擬環境中執行 script
    ```bash
    pipenv run python server.py
    ```

    也可以執行其他指令如 `pytest`
    ```bash
    pipenv run pytest
    ```

- 進入虛擬環境
    ```bash
    pipenv shell
    ```
    要離開虛擬環境時在輸入 `exit` 即可

- 用取得的 `Pipfile` 和 `Pipfile.lock` 建立虛擬環境
    ```bash
    pipenv install
    ```

    如果要連 development 環境的套件一起安裝
    ```bash
    pipenv install --dev
    ```

- 從 `requirement.txt` 建立 `Pipfile` 和 `Pipfile.lock`
    ```bash
    pipenv install
    ```

- 輸出 `requirement.txt`

    實際上不需要做這件事，  
    但在某些特殊情況下（例如特殊平台的需求）還是可以這樣做
    ```bash
    pipenv lock --requirements > requirements.txt
    ```

- 升級虛擬環境中的套件
    ```bash
    pipenv update
    ```

- 刪除目前的虛擬環境
    ```bash
    pipenv --rm
    ```

### Upgrade Pipenv
```bash
pip3 install --upgrade pipenv
```
