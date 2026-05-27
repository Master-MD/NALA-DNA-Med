# Biomedical Safety Boundaries

**CRITICAL: NOT MEDICAL ADVICE**

The NALA-DNA-Med application (across all platforms, including Windows) is designed **strictly for research support and conceptual demonstration**.

## Strict Rules for BioLab Output

1. **Demo Flags**: Every result from the BioLab service MUST contain explicit flags indicating it is a simulation:
   ```json
   {
       "DemoMode": true,
       "NotMedicalAdvice": true,
       "Confidence": "low"
   }
   ```
2. **Visual Warning**: The UI must display a clear, high-contrast warning (e.g. Red border) whenever biomedical simulation data is shown.
3. **No Clinical Decisions**: The software must never be used to diagnose, treat, prescribe, or make clinical decisions.
4. **TenantShield Logging**: All simulated interactions must be logged against a `TenantId` and `ProjectId` to ensure strict auditing of data use.

These boundaries are non-negotiable.
