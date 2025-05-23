#
# Apache v2 license
# Copyright (C) 2023 Intel Corporation
# SPDX-License-Identifier: Apache-2.0
#

output "instances" {
  sensitive = true
  value = merge({
    for i, instance in aws_instance.default : i => {
        public_ip: instance.public_ip,
        private_ip: instance.private_ip,
        user_name: local.os_image_user[local.instances[i].os_type],
        instance_type: instance.instance_type,
    }
  },
  {
    "dbinstance" = {
        endpoint: module.optimized-postgresql-server.db_endpoint,
        address: module.optimized-postgresql-server.db_hostname,
        user_name: module.optimized-postgresql-server.db_username,
        port: module.optimized-postgresql-server.db_port,
        engine: module.optimized-postgresql-server.db_engine,
        password: module.optimized-postgresql-server.db_password,
        database: "tpcc",
    }
  }
  )
}
