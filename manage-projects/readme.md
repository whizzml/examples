# List, Archive or Delete Projects Script

This WhizzML script will let the user select a bunch of projects
by applying user-provided filter conditions. The conditions are a filter
expression like the ones used in BigML's API list calls, or setting the
keywords used as tags in the project. The user can set a
limit to he number of projects that will be selected
in one execution of the script (default=10). The goal of the execution can be
either list the projects, archive their resources in a new project and
delete them, or delete the projects and the resources therein.

**DISCLAIMER**: Please, note that the `delete` option will cause the deletion
of the projects and the resources therein and is a non-undoable operation.
Use that at your own risk.

The **inputs** for the script are:

* `filter-expr`: (map) Map of parameters to be used as filter (e.g.
  {"name" "iris"}). (Default = {})
* `tags`: (string) Keyword used as tag in the resources. If empty, no
  condition will be added to the filter (default).
* `action`: (string) The action to apply to the selected projects. Choices
   are: list, archive or delete (Default = list).
* `max-projects`: (number) The maximum number of projects to be deleted
  in a single execution of the script (default).
