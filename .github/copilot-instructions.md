# Copilot Instructions for `intel-innersource/applications.ai.erag.infra-automation`

This guide is specifically designed for effective Copilot usage in the Intel AI for Enterprise Inference Repository.

---

## Project Structure

- **core/**: Main logic for automation scripts and modules.
- **third_party/**: External dependencies, integrations, or scripts.
- **docs/**: Documentation resources.
- **.github/**: GitHub workflows or issue templates.
- **.reuse/**: Licensing or code reuse configurations.

---

## Languages & Best Practices

### Shell (Bash/sh)
- Use POSIX-compliant syntax for portability.
- Prefer long-form flags and descriptive variable names.
- Always check exit codes and fail gracefully.
- For automation: modularize scripts, use functions, and document usage with `set -euo pipefail` for safety.
- Example prompt:  
  _"Write a shell script to automate deployment with error checks."_

### Jinja
- Use clear template variable names.
- Document intended logic with comments in templates.
- Example prompt:  
  _"Generate a Jinja template for Kubernetes configuration supporting dynamic model inputs."_

### Smarty
- Use for configuration or templated automation.
- Keep template logic minimal and readable.

---

## Automation Patterns

- Modular, reusable scripts for AI inference infrastructure.
- Parameterize scripts for different cloud providers and hardware configurations.
- Use configuration files (`ibm_catalog.json`, etc.) for environment-specific details.
- Store secrets and sensitive data outside of code (environment variables or secured vaults).

---

## Documentation

- Refer to `README.md` for setup, architecture, and usage.
- Update documentation (`docs/`) when introducing new automation flows or dependencies.
- Add inline comments and script headers explaining purpose, inputs, outputs, and dependencies.

---

## Security

- Review `SECURITY.md` for reporting vulnerabilities and best practices.
- Do not commit secrets, passwords, or API keys.
- Validate all inputs in scripts and templates.

---

## Testing & Validation

- Add verification steps in shell scripts (e.g., check required binaries, configuration files).
- For templates, include sample data and expected outputs.
- Use separate branches for experimental automation; merge after thorough review.

---

## Branching & Contribution

- Use descriptive branch names for features (e.g., `firmware-update-automation`, `code-promotion`).
- Prefer PRs with clear descriptions and linked documentation.
- Follow any templates in `.github/` for issues and PRs.

---

## Copilot Prompt Examples

- "Write a shell script that deploys inference services and checks for required environment variables."
- "Create a Jinja template for parameterizing model deployment."
- "Suggest error handling improvements for this bash script."
- "Document the usage for a cloud provider integration script."

---

## Additional Tips

- Ensure scripts are idempotent and safe to re-run.
- Avoid duplicating logic—reuse existing modules in `core/` or `third_party/`.
- Update the `VERSION` file when making breaking changes.

---

For full repo details, see the [README](https://github.com/intel-innersource/applications.ai.erag.infra-automation/blob/main/README.md), [SECURITY.md](https://github.com/intel-innersource/applications.ai.erag.infra-automation/blob/main/SECURITY.md), and explore the [branches](https://github.com/intel-innersource/applications.ai.erag.infra-automation/branches) for workflow examples.
