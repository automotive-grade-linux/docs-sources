# AGL CMake templates

Files used to build an application, or binding, project with the
AGL Application Framework.

To build your AGL project using these templates, you have to install
them within your project and adjust compilation option in `config.cmake`.\
For technical reasons, you also have to specify **cmake** target in
sub CMakeLists.txt installed.\
Make a globbing search to find source files
isn't recommended now to handle project build especially in a multiuser
project because CMake will not be aware of new or removed source files.

You'll find usage samples here:

- [helloworld-service](https://github.com/iotbzh/helloworld-service)
- [low-level-can-service](https://gerrit.automotivelinux.org/gerrit/apps/low-level-can-service)
- [high-level-viwi-service](https://github.com/iotbzh/high-level-viwi-service)
- [audio-binding](https://github.com/iotbzh/audio-binding)
- [unicens2-binding](https://github.com/iotbzh/unicens2-binding)

## Quickstart

### Initialization

To use these templates files on your project just install the reference files using
**git submodule** then use `config.cmake` file to configure your project specificities :

```bash
git submodule add https://gerrit.automotivelinux.org/gerrit/apps/app-templatesconf.d/app-templates conf.d/app-templates
mkdir conf.d/cmake
cp conf.d/app-templates/cmake/config.cmake.sample conf.d/cmake/config.cmake
```

Edit the copied config.cmake file to fit your needs.

Now, create your top CMakeLists.txt file which include `config.cmake` file.

An example is available in **app-templates** submodule that you can copy and
use:

```bash
cp conf.d/app-templates/cmake/CMakeLists.txt CMakeLists.txt
```

### Create your CMake targets

For each target part of your project, you need to use ***PROJECT_TARGET_ADD***
to include this target to your project.

Using it, make available the cmake variable ***TARGET_NAME*** until the next
***PROJECT_TARGET_ADD*** is invoked with a new target name.

So, typical usage defining a target is:

```cmake
PROJECT_TARGET_ADD(SuperExampleName) --> Adding target to your project

add_executable/add_library(${TARGET_NAME}.... --> defining your target sources

SET_TARGET_PROPERTIES(${TARGET_NAME} PROPERTIES.... --> fit target properties
for macros usage

INSTALL(TARGETS ${TARGET_NAME}....
```

### Targets PROPERTIES

You should set properties on your targets that will be used to package your
apps in a widget file that could be installed on an AGL system.

Specify what is the type of your targets that you want to be included in the
widget package with the property **LABELS**:

Choose between:

- **BINDING**: Shared library that be loaded by the AGL Application Framework
- **HTDOCS**: Root directory of a web app
- **DATA**: Resources used by your application
- **EXECUTABLE**: Entry point of your application executed by the AGL
 Application Framework

```cmake
SET_TARGET_PROPERTIES(${TARGET_NAME}
    PREFIX "afb-"
    LABELS "BINDING"
    OUTPUT_NAME "file_output_name")
```

> **TIP**: You should use the prefix _afb-_ with your **BINDING* targets which
> stand for **Application Framework Binding**.

## More details: Typical project architecture

A typical project architecture would be :

```tree
<project-root-path>
│
├── conf.d/
│   ├── autobuild/
│   │   ├── agl
│   │   │   └── autobuild
│   │   ├── linux
│   │   │   └── autobuild
│   │   └── windows
│   │       └── autobuild
│   ├── app-templates/
│   │   ├── README.md
│   │   ├── autobuild/
│   │   │   ├── agl
│   │   │   │   └── autobuild.in
│   │   │   ├── linux
│   │   │   │   └── autobuild.in
│   │   │   └── windows
│   │   │       └── autobuild.in
│   │   ├── cmake/
│   │   │   ├── config.cmake.sample
│   │   │   ├── export.map
│   │   │   └── macros.cmake
│   │   ├── deb/
│   │   │   └── config.deb.in
│   │   ├── rpm/
│   │   │   └── config.spec.in
│   │   └── wgt/
│   │       ├── config.xml.in
│   │       ├── config.xml.in.sample
│   │       ├── icon-default.png
│   │       ├── icon-html5.png
│   │       ├── icon-native.png
│   │       ├── icon-qml.png
│   │       └── icon-service.png
│   ├── packaging/
│   │   ├── config.spec
│   │   └── config.deb
│   ├── cmake
│   │   └── config.cmake
│   └── wgt
│      └── config.xml.in
├── <libs>
├── <target>
│   └── <files>
├── <target>
│   └── <file>
└── <target>
    └── <files>
```

| # | Parent | Description |
| - | -------| ----------- |
| \<root-path\> | - | Path to your project. Hold master CMakeLists.txt and general files of your projects. |
| conf.d | \<root-path\> | Holds needed files to build, install, debug, package an AGL app project |
| app-templates | conf.d | Git submodule to app-templates AGL repository which provides CMake helpers macros library, and build scripts. config.cmake is a copy of config.cmake.sample configured for the projects. SHOULD NOT BE MODIFIED MANUALLY !|
| autobuild | conf.d | Scripts generated from app-templates to build packages the same way for differents platforms.|
| cmake | conf.d | Contains at least config.cmake file modified from the sample provided in app-templates submodule. |
| wgt | conf.d | Contains at least config.xml.in template file modified from the sample provided in app-templates submodule for the needs of project (See config.xml.in.sample file for more details). |
| packaging | conf.d | Contains output files used to build packages. |
| \<libs\> | \<root-path\> | External dependencies libraries. This isn't to be used to include header file but build and link statically specifics libraries. | Library sources files. Can be a decompressed library archive file or project fork. |
| \<target\> | \<root-path\> | A target to build, typically library, executable, etc. |

### Update app-templates submodule

You may have some news bug fixes or features available from app-templates
repository that you want.\
To update your submodule proceed like the following:

```bash
git submodule update --remote
git commit -s conf.d/app-templates
```

This will update the submodule to the HEAD of master branch repository.

You could just want to update at a specified repository tag or branch or commit
, here are the method to do so:

```bash
cd conf.d/app-templates
# Choose one of the following depending what you want
git checkout <tag_name>
git checkout --detach <branch_name>
git checkout --detach <commit_id>
# Then commit
cd ../..
git commit -s conf.d/app-templates
```

### Build a widget

#### config.xml.in file

To build a widget you need a _config.xml_ file describing what is your apps and
how Application Framework would launch it.\
This repo provide a simple default file _config.xml.in_ that should work
for simple application without interactions with others bindings.

It is recommanded that you use the sample one which is more complete. You can
find it at the same location under the name _config.xml.in.sample_ (stunning
isn't it).\
Just copy the sample file to your _conf.d/wgt_ directory and name it
_config.xml.in_, then edit it to fit your needs.

> ***CAUTION*** : The default file is only meant to be use for a
> simple widget app, more complicated ones which needed to export
> their api, or ship several app in one widget need to use the provided
> _config.xml.in.sample_ which had all new Application Framework
> features explained and examples.

#### Using cmake template macros

To leverage all cmake templates features, you have to specify ***properties***
on your targets.\
Some macros will not works without specifying which is the target type.

As the type is not always specified for some custom targets, like an ***HTML5***
application, macros make the difference using ***LABELS*** property.

Choose between:

- **BINDING**: Shared library that be loaded by the AGL Application Framework
- **HTDOCS**: Root directory of a web app
- **DATA**: Resources used by your application
- **EXECUTABLE**: Entry point of your application executed by the AGL
 Application Framework

Example:

```cmake
SET_TARGET_PROPERTIES(${TARGET_NAME} PROPERTIES
        LABELS "HTDOCS"
        OUTPUT_NAME dist.prod
    )
```

If your target output is not named as the ***TARGET_NAME***, you need to specify
***OUTPUT_NAME*** property that will be used by the ***populate_widget*** macro.

Use the ***populate_widget*** macro as latest statement of your target
definition. Then at the end of your project definition you should use the macro
***build_widget*** that make an archive from the populated widget tree using the
`wgtpkg-pack` Application Framework tools.

## Macro reference

### PROJECT_TARGET_ADD

Typical usage would be to add the target to your project using macro
`PROJECT_TARGET_ADD` with the name of your target as parameter.

Example:

```cmake
PROJECT_TARGET_ADD(low-can-demo)
```

> ***NOTE***: This will make available the variable `${TARGET_NAME}`
> set with the specificied name. This variable will change at the next call
> to this macros.

### project_subdirs_add

This macro will search in all subfolder any `CMakeLists.txt` file. If found then
it will be added to your project.\
This could be use in an hybrid application by example where the binding
lay in a sub directory.

Usage :

```cmake
project_subdirs_add()
```

You also can specify a globbing pattern as argument to filter which folders
will be looked for.

To filter all directories that begin with a number followed by a dash the
anything:

```cmake
project_subdirs_add("[0-9]-*")
```

## Advanced customization

### Including additionnals cmake files

Advanced tuning is possible using addionnals cmake files that are included
automatically from some specifics locations.\
They are included in that order:

- Project CMake files normaly located in _\<project-root-path\>/conf.d/app-templates/cmake/cmake.d_
- Home CMake files located in _$HOME/.config/app-templates/cmake.d_
- System CMake files located in _/etc/app-templates/cmake.d_

CMake files has to be named using the following convention: `XX-***.cmake`,
where `XX` are numbers, `***` file name (ie. `99-my_customs.cmake`).

So, saying that you should be aware that every normal cmake variables used at
project level could be overwrited by home or system located cmake files if
variables got the same name.\
Exceptions are cached variables set using **CACHE** keyword:

Example:

```cmake
set(VARIABLE_NAME 'value string random' CACHE STRING 'docstring')
```

### Include customs templated scripts

As well as for additionnals cmake files you can include your own templated
scripts that will be passed to cmake command `configure_file`.

Just create your own script to the following directories:

- Home location in _$HOME/.config/app-templates/scripts_
- System location in _/etc/app-templates/scripts_

Scripts only needs to use the extension `.in` to be parsed and configured by
CMake command.

## Autobuild script usage

### Generation

To be integrated in the Yocto build workflow you have to generate `autobuild`
scripts using _autobuild_ target.

To generate those scripts proceeds:

```bash
mkdir -p build
cd build
cmake .. && make autobuild
```

You should see _conf.d/autobuild/agl/autobuild_ file now.

### Available targets

Here are the available targets available from _autobuild_ scripts:

- **clean** : clean build directory from object file and targets results.
- **distclean** : delete build directory
- **configure** : generate project Makefile from CMakeLists.txt files.
- **build** : compile all project targets.
- **package** : build and output a wgt package.

You can specify variables that modify the behavior of compilation using
the following variables:

- **CONFIGURE_ARGS** : Variable used at **configure** time.
- **BUILD_ARGS** : Variable used at **build** time.
- **DEST** : Directory where to output ***wgt*** file.

Variable as to be in CMake format. (ie: BUILD_ARGS="-DC_FLAGS='-g -O2'")

Usage example:

```bash
./conf.d/autobuild/wgt/autobuild package DEST=/tmp
```
