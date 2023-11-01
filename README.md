# Introduction to Cloud Native Geospatial

This repository includes the container environment build scripts and notebooks
for use in the Element 84 workshop "Introduction to Cloud Native Geospatial".

For more context on Cloud Native Geospatial please see [the workshop slide
deck](https://docs.google.com/presentation/d/1iSAwpxt6nSkiq3EXwxK4DgW0MMLdJqzDh7lj1mC119Y/edit#slide=id.p).

## Setting up local environment

To run the notebooks with coiled one first needs to setup a local environment
with coiled. The easiest way to do this is typically using a python virtual
environment and `pip`:

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
❯ coiled notebook start --software cng-workshop --account element84-demo-workspace
```

Running this command will trigger coiled to spin up a new instance to run the
server, and it will open a borswer tab for jupyter lab once it is running. The
notebooks and AOIs from this repo are built into the image, so simply browse to
the desired notebook in the file explorer and open it.

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

`git` is built into the image, and can be a useful when testing changes to the
notebooks or loading notebooks from other sources without having to build them
into the image. For example, to clone this repo into the environment to test
changes, open a terminal in jupyter lab and run the following command:

```cmdline
❯ git clone https://github.com/Element84/cng-workshop
```
