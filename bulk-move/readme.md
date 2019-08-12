# Bulk Move Script

This WhizzML script will let the user move a buch of resources to a
specific project in BigML. The resources are selected
by applying user-provided filter conditions.

The **inputs** for the script are:

* `destination-project`: (project-id) Project ID to move the resources to.
* `source-project`: (project-id) Project ID of the resources to be selected
  If empty, no condition will be added to the filter (default).
* `tags`: (string) Keyword used as tag in the resources. If empty, no
  condition will be added to the filter (default).
* `filter-expr`: (map) Map of parameters to be used as filter (e.g.
  {"name" "iris"}). (Default = {})
* `res-types`: (list) Only resources that comply with these types
  are selected (e.g. ["source" "ensemble"]). If empty, all resource types
  will be returned (default).
* `dry-run`: (boolean) If true, nothing is changed and the IDs of the resources
  to be moved are logged (default).
