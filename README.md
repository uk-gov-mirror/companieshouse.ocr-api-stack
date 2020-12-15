# ocr-api-stack

Infrastructure for the ocr-api service stack.

This consists of one ECS Cluster with one microservice (ocr-api)

Notes on the internal / external naming:

- internal = DNS names within the AWS cluster that are only used for traffic within (internal to) the environment
- external = DNS names exposing specific services to users outside (external to) the cluster e.g. other CH services, testers etc
- so its not a public/private thing its how functionality/services are used - within the cluster is internal DNS, outside users require the external address.
