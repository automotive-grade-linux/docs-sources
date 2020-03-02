# SDK devkit

This repository holds AGL documentation (written by the IoT.bzh team) which is
 not yet merged into official AGL repository.

## How to generate pdf

Documentation is based on [gitbook](https://www.gitbook.com/).
To install locally gitbook:

```bash
npm install -g gitbook-cli
```

To generate documentation:

```bash
./gen_all_docs.sh
```

or to generate one individual doc manually:
You must install calibre first :

```bash
sudo apt install calibre
```

```bash
gitbook pdf ./sdk-devkit ./build/sdk-devkit.pdf
```

## Notes / TODO

* Add Iot.Bzh logo in header instead of IoT.Bzh text
* Write a plugin based on svg + convert to generate cover.
