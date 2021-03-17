# ocr-api-stack

Infrastructure for the ocr-api service stack.

This consists of one ECS Cluster with one microservice (ocr-api)

## Performance Variables

These are configured in the profile environmental vars files (no defaults set):

|     Variable       | Description                                                               |
|---                 |---                                                                        |
| ocr_tesseract_thread_pool_size  | The number of threads used in the ocr-api application for Tesseract processing (Image to text) |

## Internal / external naming

Notes on the internal / external naming:

- internal = DNS names within the AWS cluster that are only used for traffic within (internal to) the environment
- external = DNS names exposing specific services to users outside (external to) the cluster e.g. other CH services, testers etc
- so its not a public/private thing its how functionality/services are used - within the cluster is internal DNS, outside users require the external address.

## Secrets

No secrets are required in this application stack
