vCloud Disk Launcher
====================

A tool that takes a YAML or JSON configuration file describing a list of
Independent Disks in a vCloud Director Organisation, and provisions them
as needed.

### Supports

- Configuration of multiple Independent Disks with:
  - custom name
  - custom size
- Basic idempotent operation - disks that already exist are skipped.
- Adds helper code to prevent creation of disks with the same name.

### Limitations

- Does not yet support configuration of the storage profile of an independent
  disk. The default storage profile for the vDC is used.

## Installation

Add this line to your application's Gemfile:

    gem 'vcloud-disk_launcher'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install vcloud-disk_launcher


## Usage

`vcloud-disk_launch disk_list.yaml`

## Configuration schemas

Configuration schemas can be found in [`lib/vcloud/disk_launcher/schema/`][schema].

[schema]: /lib/vcloud/disk_launcher/schema

## Credentials

Please see the [vcloud-tools usage documentation](http://gds-operations.github.io/vcloud-tools/usage/).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Other settings

vCloud Disk Launcher uses vCloud Core. If you want to use the latest version of
vCloud Core, or a local version, you can export some variables. See the Gemfile
for details.

## The vCloud API

vCloud Tools currently use version 5.1 of the [vCloud API](http://pubs.vmware.com/vcd-51/index.jsp?topic=%2Fcom.vmware.vcloud.api.doc_51%2FGUID-F4BF9D5D-EF66-4D36-A6EB-2086703F6E37.html). Version 5.5 may work but is not currently supported. You should be able to access the 5.1 API in a 5.5 environment, and this *is* currently supported.

The default version is defined in [Fog](https://github.com/fog/fog/blob/244a049918604eadbcebd3a8eaaf433424fe4617/lib/fog/vcloud_director/compute.rb#L32).

If you want to be sure you are pinning to 5.1, or use 5.5, you can set the API version to use in your fog file, e.g.

`vcloud_director_api_version: 5.1`

## Debugging

`export EXCON_DEBUG=true` - this will print out the API requests and responses.

`export DEBUG=true` - this will show you the stack trace when there is an exception instead of just the message.

## Testing

Run the default suite of tests (e.g. lint, unit, features):

    bundle exec rake

Run the integration tests (slower and requires a real environment):

    bundle exec rake integration

You need access to a suitable vCloud Director organization to run the
integration tests. See the [integration tests README](/spec/integration/README.md) for
further details.
