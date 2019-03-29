# Abstract

AGL doc website is based on a collection of markdown files fetched from various repositories.
A tool available in [docs-tools](https://github.com/automotive-grade-linux/docs-tools) takes
care of collecting and templating all markdown files according fetched_files.yml located in
[docs-webtemplate](https://github.com/automotive-grade-linux/docs-webtemplate).

See below a scheme of the workflow of agl documentation website generation.

![alt text](pictures/workflow.png)

As you can see, the section_``version``.yml contains the links to all the book yaml files, it is proceed to fetch all book yaml files from remote repositories to the docs-webtemplate. The book yaml files contains all the url to your markdown files from the remote repository.

As soon as all the markdown files are fetched, the tools process to generate the AGL doc website.

---

**Note:**

The images described in markdown files are automatically fetched. For that, the necessary condition is that in markdown files, the relative path has to match with the location of images.

---

## How to add a new documentation section into AGL documentation

They are two steps to add new markdown files to AGL documentation:

- Add a book yaml file to the repository where the documentation sources are located (written in markdown files).
- Add an entry into the global section yaml file that point to your book file. The section yaml file is in [docs-webtemplate](https://github.com/automotive-grade-linux/docs-webtemplate) repository (`git@github.com:automotive-grade-linux/docs-webtemplate.git`) named `section_<version>.yml`.

---

**Note**: To generate a local documentation please refer to the [README](https://github.com/automotive-grade-linux/docs-webtemplate/blob/master-next/README.md) of the docs-webtemplate (https://github.com/automotive-grade-linux/docs-webtemplate) and use `setupdocs.sh` script.

---

### Add a book yaml file into a repository

The book file is needed to describe how your documentation is structured and must be used to describe
among others :

- the global title of the doc
- the chapter name when the doc will be part of the whole documentation website
- subchapters list and consequently subchapters hierarchy
- multi-language description

---

**Note:**

Multi-language is handled by key suffixes. That is to say, there are some keys that can be suffixed by a language: ``<key>_<lang>``
For the url to the markdown files, the prefix ```%lang%``` will match with suffixes. So, you have to create a subdirectory named ```%lang%``` where the markdown files are put.

A example for the french:

```
name: "My section in english"
name_fr: "Ma section en français"
url: "%lang/section.md"
```

```
$ ls -lR mydir
book.yml
section.md
fr/section.md
```

---

There are several types of book:

- book
- api

#### Book Type

`book` type describes documentation structure and chapters.
Below the generic way to include a book file:

```yaml
type: books
books:
-
    id: <ID1>
    order: x #optional: between 0 in 100 default when not set is 50, it allows to define order in final
             #documentation, more the order number is low more the documentation is first
    title: title of your chapter  #default title
    title_<lang>: title in <lang>
    description: description of your book
    keywords: some keywords
    author: author of the documentation
    version: version of the documentation
    chapters:
        - name: Name of your subchapter
          name_<lang>: Name of your subchapter in <lang>
            url: "%lang%/relative-path/to/your/mardown.md" #%lang% will be replaced by the
                                                           #available languages,
                                                           #default language can be in the root directory
        - name: Name of your subchapter
          name_<lang>: Name of your subchapter in <lang>
          url: "%lang%/relative-path/to/your/mardown.md"
        - name: Name of your subchapter
          name_<lang>: Name of your subchapter in <lang>
            - name: Name of your subsubchapter
              name_<lang>: Name of your subsubchapter in <lang>
              url: "%lang%/relative-path/to/your/mardown.md"
            - name: Name of your subsubchapter
              name_<lang>: Name of your subsubchapter in <lang>
              children:
                - ...
            - ...
        - ...
-
    id: <ID2>
    ...
```

[book.yml.in](https://github.com/automotive-grade-linux/docs-sources/blob/master/docs/handle-docs/book.yml.in)
is a sort of schema of book.yml. This file contains all supported keys.

Here a sample yaml file, you can start from :

```bash
wget https://raw.githubusercontent.com/automotive-grade-linux/docs-sources/master-next/docs/getting-started-book.yml -O my-new-book.yml
```

#### Api Type

In progress

### Add an entry in section file

There are 4 sections in docs: getting_started, architecture_guides, developer_guides, apis_services.

They are located in `content/docs` in [docs-webtemplate](https://github.com/automotive-grade-linux/docs-webtemplate) repository.
In addition, each directory contains several section yaml file, one a version. For master version, it is `section_master.yml`.

Below the structure of section yaml file.

```yaml
url_fetch : DEFAULT_URL_FETCH #this the default url_fetch that can be overload further, there already are some default variables defined in docs-webtemplate/docs-tools
git_commit : DEFAULT_VERSION #this is the default git_commit that can be overload further, there already are some default variables defined in docs-webtemplate/docs-tools

name: Name of the section
template: generated_index.html
books:
-
    id: <ID1>
    url_fetch: <url_fetch> #optional, overload the default one
    git_commit: <git_commit> #optional, overload the default one
    path: "relativepath/from/root/repository/to/the/book/yaml/file"
    books: #optional: subbooks, will be a child of the above book
        - id: <SUBID2>
          url_fetch: <url_fetch> #optional, overload the default one
          git_commit: <git_commit> #optional, overload the default one
          path: "relativepath/from/root/repository/to/the/book/yaml/file"
        - ...
-
    id: <ID2>
    ...
```
