pupppet-sensu-profile
=====================

Setup
-----

```bash
vagrant plugin install vagrant-hostmanager
vagrant plugin install vagrant-r10k
vagrant up
```

Visit localhost:3000 to view the uchiwa dashboard on sensu1

SSL Setup
---------

Follow the steps to generate the SSL certs in https://www.rabbitmq.com/ssl.html
Then copy the server (rabbitmq) and client (sensu) pems into puppet/modules/ssl_certs/files

```bash
$ tree puppet/modules/ssl_certs/
puppet/modules/ssl_certs/
└── files
    ├── cacert.pem
    ├── rabbitmq_cert.pem
    ├── rabbitmq_key.pem
    ├── sensu_cert.pem
    └── sensu_key.pem
```
