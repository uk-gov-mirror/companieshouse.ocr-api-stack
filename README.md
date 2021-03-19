# ocr-api-stack

Infrastructure for the ocr-api service stack.

This consists of one ECS Cluster with one microservice (ocr-api)

## Performance Variables

These are configured in the profile environmental vars files (no defaults set):

|     Variable                    | Description                                                                       |
|---                              |---                                                                                |
| ec2_instance_type               | See [AWS Instance Types)[https://aws.amazon.com/ec2/instance-types/]              |
| number_of_tasks                 | The number of instances of the ocr-api task to run                                |
| machine_cpu_count               | The number of vCPUs the ocr-api uses.                                             |
| machine_amount_of_memory_mib    | The amount of memory in MiB to allocate to the ocr-api.                                  |
| ocr_tesseract_thread_pool_size  | The number of threads used in the ocr-api application for Tesseract processing (Image to text) |

** Make sure that the CPU and Memory values are in the range of the ec2_instance_type (the plan will be made and applied but fail in deployment with no clear error messages).

## Internal / external naming

Notes on the internal / external naming:

- internal = DNS names within the AWS cluster that are only used for traffic within (internal to) the environment
- external = DNS names exposing specific services to users outside (external to) the cluster e.g. other CH services, testers etc
- so its not a public/private thing its how functionality/services are used - within the cluster is internal DNS, outside users require the external address.

## Secrets

No secrets are required in this application stack
