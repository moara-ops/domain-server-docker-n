#! /bin/bash
# Push the local image named "vircadia-domain-server" to the repository.
# The image tag is set to "latest" and the version generated by the 'getVersion.sh' command.

# The repository image name can be over-ridden with the environment variable REPO_IMAGE.

export DOCKER_REPOSITORY=${DOCKER_REPOSITORY:-allibay}
export IMAGE_NAME=${IMAGE_NAME:-enverse-domain-server}
export IMAGE_VERSION=${IMAGE_VERSION:-latest}

VERSIONLABEL=$(docker run --rm --entrypoint /home/cadia/getVersion.sh enverse-domain-server VERSION_TAG)

echo "Pushing docker image for domain-server version ${VERSIONLABEL}"

for tagg in ${VERSIONLABEL} ${IMAGE_VERSION} ; do
    IMAGE=${DOCKER_REPOSITORY}/${IMAGE_NAME}:${tagg}
    docker tag ${IMAGE_NAME} ${IMAGE}
    echo "   Pushing ${IMAGE}"
    docker push ${IMAGE}
done
