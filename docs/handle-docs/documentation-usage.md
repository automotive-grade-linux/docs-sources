# Documentation Usage

The [docs-webtemplate](https://github.com/automotive-grade-linux/docs-webtemplate)
repository contains AGL documentation website template, rendering is visible at
<https://docs.automotivelinux.org.>
This website relies on the generator located in
[docs-tools](https://github.com/automotive-grade-linux/docs-tools).

## Download Sources

Get the ```setupdocs.sh``` script to initialize your environment.

```bash
wget https://raw.githubusercontent.com/automotive-grade-linux/docs-webtemplate/master/setupdocs.sh
```

This script fetches [docs-tools](https://github.com/automotive-grade-linux/docs-tools), install npm modules.

```bash
mkdir docs-webtemplate
bash setupdocs.sh --directory=docs-webtemplate
```

For consulting help, do:

```bash
bash setupdocs.sh --help
```

## Building a local site

In docs-webtemplate directory:

```bash
make serve
```

For cleaning your work, use:

```bash
make clean
```

## Documentation from local repositories

It is also possible to use markdown files from local repositories.

For local fetch, a specific file named  ```__fetched_files_local.yml```
was introduced.

This file is used to overload ```url_fetch``` in section_<version>.yml
in order to use local repositories on not remote ones.

Thus, this file is needed to be added in the docs-webtemplate root,
see an example below:

```bash
############__fetched_files_local.yml##############
-
    url_fetch : <pathToDocsSources>/docs-sources/
    git_name   : automotive-grade-linux/docs-sources
-
    url_fetch : <pathToXdsDocs>/xds-docs/
    git_name   : src/xds/xds-docs
-
    git_name: AGL/meta-renesas-rcar-gen3
    url_fetch: <pathToMetaRenesas>/meta-renesas-rcar-gen3
###################################################
```

It is also possible to use ```id``` instead of ```git_name```.

## Test Hyperlinks

[LinkChecker](https://wummel.github.io/linkchecker/) is a tool that allows to check all the hyperlinks in the site.

For testing hyperlinks as soon as the local site is running, do:

```bash
make linkchecker
```

or

```bash
linkchecker http://localhost:4000
```

The ```linkchecker``` output will display the broken link and there location
in the site.
