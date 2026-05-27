using System;
using System.Threading.Tasks;
using NalaDnaMedWin.Models;

namespace NalaDnaMedWin.Services
{
    public enum LlmProfile
    {
        Kleiner,
        Optimal,
        Maximal
    }

    public class LLMFitService
    {
        public Task<LlmProfile> GetRecommendedProfileAsync()
        {
            // Note: In the real implementation, this would detect:
            // 1. Total System RAM
            // 2. GPU Capabilities (DirectX / VRAM)
            // 3. Free Disk Space on C: drive
            // 4. Presence of WSL2 / Docker Desktop
            
            // For now, based on the requirements for Local Lite without Docker,
            // and the "disk space is the limiting factor" note, we default to Kleiner.
            return Task.FromResult(LlmProfile.Kleiner);
        }
    }

    public class BioLabService
    {
        public Task<BioLabResponse> RunDryRunAnalysisAsync(string tenantId, string projectId, string query)
        {
            // TenantShield Validation
            if (string.IsNullOrEmpty(tenantId) || string.IsNullOrEmpty(projectId))
            {
                throw new UnauthorizedAccessException("Tenant or Project context is missing. Request blocked by TenantShield.");
            }

            var response = new BioLabResponse
            {
                DemoMode = true,
                NotMedicalAdvice = true,
                Confidence = "low",
                ResultText = $"[DEMO RESULT] Simulated analysis for query: '{query}'. \n\n" +
                             $"WARNING: This is a synthetic output for research UI demonstration purposes only. " +
                             $"No real biomedical inference was performed."
            };

            return Task.FromResult(response);
        }
    }
}
