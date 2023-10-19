# Introduction to Cloud Native Geospatial

This repository includes the container environment build scripts and notebooks
for use in the Element 84 workshop "Introduction to Cloud Native Geospatial".

## Setting up local environment

To run the notebooks with coiled one first needs to setup a local environment
with coiled. The easiest way to do this is typically using a python virtual and
`pip`:

```cmdline
# create a local working directory and change into it
❯ mkdir cng-workshop
❯ cd cng-workshop

# create a python virtual env (at time of writing python 3.7-3.11 supported)
❯ python -m venv .venv

# activate the virtual environment
❯ source .venv/bin/activate

# install coiled
❯ pip install coiled

# login to coiled
❯ coiled login


```

Feel free to use any other prefered python environment/package managers (like
conda/mamba) to setup a virtual environment and/or install coiled.

## Running a notebook with coiled

Coiled allows launching jupyter on an ephemeral cloud machine with a
pre-configured software environment. The included Dockerfile defines a
geospatial container image and python environment suitable for running the
notebooks in the repo; this is published as a public image to AWS ECR with the
image `public.ecr.aws/q2i2x3t4/e84-sandbox/coiled-demo:latest`. We can use this
container image with a coiled software environment (the included script
`./scripts/create-software-env.py`) can be run to setup a software environment
called `cng-workshop` if it does not already exist in your coiled context).

Understanding this, all we need to do to run our jupyter server is the following:

```cmdline
❯ coiled notebook start --software cng-workshop
```

Running this command will trigger coiled to spin up a new instance to run the
server, and it will open a borswer tab for jupyter lab once it is running.

To load the notebooks from this repo, open a terminal in jupyter lab and clone
this repo with the following command:

```cmdline
❯ git clone https://github.com/Element84/cng-workshop
```

Then, simply browse to the desired notebook in the jupyter lab file explorer,
such as `./notebooks/sentinel2.ipynb`.

## Building the container image

If wanting to build the container image for oneself, simply (requires the
docker cli and a docker daemon to be running):

```cmdline
❯ docker build .
```

For Element 84 maintainers, `./scripts/build.bash` is provided to automate
building the image for both linux/amd64 and linux/arm64 and pushing those
images to the ECR repo, tagged as latest. Note that AWS credentials with write
access to that ECR repo in the sandbox account are requried.
