# Intel AI for Enterprise Inference - CPU Optimization

## Overview

The system automatically optimizes CPU allocation for AI models using balloon policy. This happens automatically in the background - no customer configuration required.

## Automatic Features

### CPU Allocation
- System automatically detects available CPU cores
- Reserves 18% of CPUs for system processes
- Allocates remaining CPUs to AI models
- Assigns dedicated CPU cores to each model

### Hardware Detection
- Automatically detects NUMA topology
- Configures optimal parallelism strategy
- Adjusts resource allocation based on hardware

## Configuration

### Model Requirements
Models must include this label to receive CPU optimization:
```yaml
labels:
  name: vllm
```

### Resource Allocation
```yaml
# Example for 48-core system
resources:
  requests:
    cpu: 40        # Automatically calculated
    memory: 4G
```

## Status Verification

### Check System Status
```bash
# Verify balloon policy is running
kubectl get pods -n kube-system | grep nri-resource-policy

# Check model CPU allocation
kubectl exec <model-pod> -- cat /proc/self/status | grep Cpus_allowed_list
```

### Troubleshooting
If models aren't performing optimally:

1. Verify balloon policy pod is running
2. Check model pod has `name: vllm` label
3. Confirm CPU allocation in pod status

## Summary

CPU optimization runs automatically and provides:
- Dedicated CPU cores for each model
- Consistent performance
- Optimal resource utilization
