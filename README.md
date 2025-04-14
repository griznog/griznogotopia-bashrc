# griznogotopia-bashrc


## Installation.

Add the repo as `~/.bashrc.griznog.d`

```
git clone git@github.com:griznog/griznogotopia-bashrc.git ${HOME}/.bashrc.griznog.d
```

To the end of your ~/.bashrc file, add

```
# Include griznog foo.
for file in ${HOME}/.bashrc.griznog.d/*.sh; do
  . ${file}
done
```

