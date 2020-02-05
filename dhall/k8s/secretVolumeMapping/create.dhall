\(values: ./input.dhall) ->

let VolumeMount                  = ../../dependencies/dhall-kubernetes/types/io.k8s.api.core.v1.VolumeMount.dhall
let Volume                       = ../../dependencies/dhall-kubernetes/types/io.k8s.api.core.v1.Volume.dhall

let defaultVolumeMount           = ../../dependencies/dhall-kubernetes/defaults/io.k8s.api.core.v1.VolumeMount.dhall
let defaultVolume                = ../../dependencies/dhall-kubernetes/defaults/io.k8s.api.core.v1.Volume.dhall
let defaultSecretVolumeSource = ../../dependencies/dhall-kubernetes/defaults/io.k8s.api.core.v1.SecretVolumeSource.dhall
let defaultKeyToPath             = ../../dependencies/dhall-kubernetes/defaults/io.k8s.api.core.v1.KeyToPath.dhall

in {
  volumeMount = (defaultVolumeMount // {
    name = values.name,
    mountPath = values.mountPath
  } // {
    subPath = Some values.item
  }) : VolumeMount,
  volume = (defaultVolume // {
    name = values.name
  } // {
    secret = Some (defaultSecretVolumeSource // {
      secretName = Some values.secretName,
      defaultMode = Some values.defaultMode,
      items = [
        defaultKeyToPath // {
          key = values.name,
          path = values.item
        }
      ]
    })
  }) : Volume
}