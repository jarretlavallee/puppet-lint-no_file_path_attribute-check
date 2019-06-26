# puppet-lint recurse file check

Extends puppet-lint to ensure that file resources do not have `recurse` enabled. This can lead to performance issues in Puppetserver and PuppetDB when there are thousands of subdirectories or files that are managed. It is suggested to use an alternate approach for managing those directories.

This plug-in to `puppet-lint` will flag the a file resource that has `recurse => true` similar to the following.

```
  file { '/tmp/installer':
    ensure => absent,
    recurse => true,
  }
```

Or something like the following.

```
  file { '/data':
    owner => 'root',
    recurse => true,
  }
```

While the code above is functional, it will create a resource event for each file or directory under the `/tmp/installer` directory when it is being removed. This artificially bloats the report as the number of files increases. We have seen this done with directories of hundreds or thousands of files, which has created reports of over 256MB. An `exec` resource may be a better solution for this type of file management.

## Installation

To install this for the local `puppet-lint` command line utility it can be installed with the following.

```
gem install puppet-lint-recurse_file-check
```

To use this plug-in with `bundler`, add the following line to your Gemfile.

```
gem 'puppet-lint-recurse_file-check'
```

and then run `bundle install`.


## Usage

This plug-in provides a new check to `puppet-lint`. The following is the output which will be shown.

> recurse file resources can cause decreased performance
