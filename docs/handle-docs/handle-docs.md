# How to add markdown files to AGL documentation

This documentation helps you to add new markdown files to AGL documentation.
They are two steps to add new markdown files to AGL documentation:

- Add a book yaml file to the repository where the markdown files are.
- Add an entry into the section yaml file that point to your book file. The section yaml file is in docs-webtemplate repository (git@github.com:automotive-grade-linux/docs-webtemplate.git) named ```section_<version>.yml```.

---

**Note**: To generate a local documentation please refer to the README of the docs-webtemplate (https://github.com/automotive-grade-linux/docs-webtemplate) and use the script ```setupdocs.sh```.

---

## Add a book yaml file into repository

The book file is needed to describe your documentation.
There are several types of book:

- book
- api

### Book Type

The book type describes documentation chapters.
Below the generic way to include a book file:

```yaml
type: books
books:
-
    id: <ID1>
    order: x #optional: between 0 in 100 default is 50, it allows to define order in final          #documentation, more the order number is low more the documentation is first
    title: title of your chapter  #default title
    title_<lang>: title in <lang>
    description: description of your book
    keywords: some keywords
    author: author of the documentation
    version: version of the documentation
    chapters:
        - name: Name of your subchapter
          name_<lang>: Name of your subchapter in <lang>
            url: "%lang%/softlink/to/your/mardown.md" #%lang% will be replaced by the
                                                      #available languages,
                                                      #default language can be in the root directory
        - name: Name of your subchapter
          name_<lang>: Name of your subchapter in <lang>
          url: "%lang%/softlink/to/your/mardown.md"
        - name: Name of your subchapter
          name_<lang>: Name of your subchapter in <lang>
            - name: Name of your subsubchapter
              name_<lang>: Name of your subsubchapter in <lang>
              url: "%lang%/softlink/to/your/mardown.md"
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

Here a simple yaml file, you can start from :

```bash
wget https://raw.githubusercontent.com/automotive-grade-linux/docs-sources/master/docs/handle-docs/simple-book.yml
```

### Api Type

In progress

## Add an entry in section file

There are 4 sections in docs: getting_started, architecture_guides, developer_guides, apis_services.

They are located in content/docs in docs-webtemplate repository. In addition, each directory contains several section yaml file, one a version. For master version, it is ```section_master.yml```.

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
    path: "softpath/from/root/repository/to/the/book/yaml/file"
    books: #optional: subbooks, will be a child of the above book
        - id: <SUBID2>
          url_fetch: <url_fetch> #optional, overload the default one
          git_commit: <git_commit> #optional, overload the default one
          path: "softpath/from/root/repository/to/the/book/yaml/file"
        - ...
-
    id: <ID2>
    ...
```