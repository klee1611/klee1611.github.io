---
title: "Pipenv Notes"
date: 2021-09-26T18:34:23+08:00
categories:
- Develop environment
tags: [Programming, Python, Pipenv]
slug: 'pipenv-notes'
---
## Why Pipenv
When maintaining many Python projects,  
different projects might use different versions of the same Python libraries.  
Not using a virtual environment and installing all Python modules directly on your machine will lead to version conflicts.  

In the past, the mechanism of `virtualenv` + `requirements.txt` allowed different projects to use different versions of the same package,  
and also enabled new developers or production environments to quickly install the packages required by the project.  
<!--more-->
However, updating packages was quite troublesome,  
requiring manual re-exporting of a new `requirements.txt`.  
Furthermore, when a project had different environment requirements (e.g., development environment and production environment),  
two sets of package configurations, `requirements-prod.txt` and `requirements-dev.txt`, had to be maintained.  
Without `pyenv`, it was also impossible to switch between different Python versions.  

Later, the officially recommended `pipenv` from Python solved these problems,  
making it convenient to achieve the following with just commands:  
- Create independent Python versions and package virtual environments.
- Install and record package versions in automatically generated `Pipfile` and `Pipfile.lock`, while checking package security through package hash values.
- Record package usage environments (separating development and production environments).
- Read `.env` files to set environment variables for the virtual environment.
- Automatically switch Python versions in the system (or Python versions installed with `pyenv`).

## Operating Pipenv
### Install Pipenv

```bash
pip3 install pipenv
```

### Pipenv Commands

- Create an independent virtual environment for a specific Python version:

    Navigate to the project directory.
    ```bash
    pipenv --python 3.8
    ```
    - Note that the specified Python version must be available on the system; otherwise, you need to install it using `pyenv`.

- Install packages
    ```bash
    pipenv install flask
    ```

- Install development packages

    Packages with `--dev` will be placed under `[dev-packages]` in the automatically generated `Pipfile`.
    ```bash
    pipenv install pytest --dev
    ```

- Uninstall packages
    ```bash
    pipenv uninstall flask
    ```

- Execute scripts in the created virtual environment
    ```bash
    pipenv run python server.py
    ```

    Other commands like `pytest` can also be executed.
    ```bash
    pipenv run pytest
    ```

- Enter the virtual environment
    ```bash
    pipenv shell
    ```
    To exit the virtual environment, simply type `exit`.

- Create a virtual environment using existing `Pipfile` and `Pipfile.lock`
    ```bash
    pipenv install
    ```

    To install development environment packages as well:
    ```bash
    pipenv install --dev
    ```

- Create `Pipfile` and `Pipfile.lock` from `requirements.txt`
    ```bash
    pipenv install
    ```

- Output `requirements.txt`

    This is generally not necessary,
    but in some special cases (e.g., requirements for specific platforms), it can still be done.
    ```bash
    pipenv lock --requirements > requirements.txt
    ```

- Upgrade packages in the virtual environment
    ```bash
    pipenv update
    ```

- Delete the current virtual environment
    ```bash
    pipenv --rm
    ```

### Upgrade Pipenv
```bash
pip3 install --upgrade pipenv
```
