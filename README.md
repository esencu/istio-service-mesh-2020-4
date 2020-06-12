* GIT: https://github.com/esencu/istio-service-mesh-2020-4
* DockerHub: https://hub.docker.com/repository/docker/neciro/istio-course
* All homeworks ad locatetd in folders `Session?/homework`
* The yaml files use the same folder structure as `IstioProject`
* The output screenshots in the `screenshot` folder inside `homework`
* To redeploy course application run script `redeploy-istio-lessons.sh`.  
  * It deploys all stuff in the `istio-lessons` namespace by default.  
    If namespace is not created it will be created.  
    The namespace name can be ovveriden by `ISTIO_LESSONS_NS` env variable or by command line parameter.
      e.g.:

      ```sh
      ./redeploy-istio-lessons.sh some-other-ns
      ```

  * **WARN**: Before deploy script removes all resourses marked with `project=istio-course` label in **ALL** namespaces
