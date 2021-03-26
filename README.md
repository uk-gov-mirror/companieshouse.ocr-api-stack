# ocr-api-stack

Infrastructure for the ocr-api service stack.

This consists of one ECS Cluster with one microservice (ocr-api)

## Performance Variables

These are configured in the profile environmental vars files (no defaults set):

|     Variable                   | Destroy | Description                                                                       |
|---                             |--- |---                                                                                |
| ec2_instance_type              | Y | See [AWS Instance Types)[https://aws.amazon.com/ec2/instance-types/]              |
| number_of_tasks                | ? | The number of instances of the ocr-api task to run                                |
| machine_cpu_count              | ? | The number of vCPUs the ocr-api uses.                                             |
| machine_amount_of_memory_mib   | ? | The amount of memory in MiB to allocate to the ocr-api.                                  |
| ocr_tesseract_thread_pool_size | N | The number of threads used in the ocr-api application for Tesseract processing (Image to text) |

- The **"Destroy"** column signifies that the environment should first be destroyed before applying this change to the environment (the main problem seems to be when we change to a more powerful environment),
- If you create a cluster with **more than two tasks,** only two tasks will be running after creation,
- **Make sure that the CPU and Memory values are in the range of the ec2_instance_type.**  The instance type might define the overall memory and CPU in the cluster - Need to confirm (getting inconsistent results). When these do NOT match, the plan will be made and applied but fail in deployment with no clear error messages.

## Internal / external naming

Notes on the internal / external naming:

- internal = DNS names within the AWS cluster that are only used for traffic within (internal to) the environment
- external = DNS names exposing specific services to users outside (external to) the cluster e.g. other CH services, testers etc
- so its not a public/private thing its how functionality/services are used - within the cluster is internal DNS, outside users require the external address.

## Secrets

No secrets are required in this application stack
