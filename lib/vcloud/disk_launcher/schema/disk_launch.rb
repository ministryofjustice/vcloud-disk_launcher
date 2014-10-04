module Vcloud
  module DiskLauncher
    module Schema

      DISK_LAUNCH = {
        type: 'hash',
        internals: {
          independent_disks: {
            type: 'array',
            required: true,
            allowed_empty: true,
            each_element_is: {
              type: 'hash',
              internals: {
                name: {
                  type: 'string',
                  required: true,
                },
                vdc_name: {
                  type: 'string',
                  required: true,
                },
                size: {
                  type: 'string',
                  required: true,
                },
              },
            },
          },
        },
      }

    end
  end
end
