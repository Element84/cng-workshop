#!/usr/bin/env python
import coiled

ENV_NAME = "cng-workshop"
CONTAINER = "public.ecr.aws/q2i2x3t4/e84-sandbox/coiled-demo"

coiled.create_software_environment(
    name=ENV_NAME,
    container=CONTAINER,
    force_rebuild=True,
)
