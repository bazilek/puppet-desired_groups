# == Class: desired_groups
#
# Class contain custom type desired_groups.
# Now you can manage group membership in "safe way".
# Define any desired groups for user. If group
# exists on hosts user will be added to it, if
# not - type won't fail.
#
# === Examples
#
#  desired_groups { 'bob':
#    groups => [ 'mysql', 'adm', 'hadoop' ],
#  }
#
# === Authors
#
# Vasil Mikhalenya <bazilek@gmail.com>
#
# === Copyright
#
# Copyright 2013 Vasil Mikhalenya
#
class desired_groups {


}
