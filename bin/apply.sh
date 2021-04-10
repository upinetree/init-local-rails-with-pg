#!/bin/bash

set -eux

git apply - <<PATCH
diff --git a/config/database.yml b/config/database.yml
index 2756232..b3f19b9 100644
--- a/config/database.yml
+++ b/config/database.yml
@@ -17,6 +17,10 @@
 default: &default
   adapter: postgresql
   encoding: unicode
+  username: postgres
+  password: password
+  host: localhost
+  port: 5432
   # For details on connection pooling, see Rails configuration guide
   # https://guides.rubyonrails.org/configuring.html#database-pooling
   pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
diff --git a/docker-compose.yml b/docker-compose.yml
new file mode 100644
index 0000000..9c364d3
--- /dev/null
+++ b/docker-compose.yml
@@ -0,0 +1,14 @@
+version: "3.9"
+
+services:
+  db:
+    image: postgres:latest
+    ports:
+      - 5432:5432
+    volumes:
+      - pg-data:/var/lib/postgresql/data
+    environment:
+      POSTGRES_PASSWORD: password
+
+volumes:
+  pg-data:
PATCH
