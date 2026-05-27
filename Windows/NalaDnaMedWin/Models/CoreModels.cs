using System;

namespace NalaDnaMedWin.Models
{
    public class Tenant
    {
        public string Id { get; set; } = Guid.NewGuid().ToString();
        public string Name { get; set; } = "Local Lite Tenant";
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    }

    public class Project
    {
        public string Id { get; set; } = Guid.NewGuid().ToString();
        public string TenantId { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    }

    public class Document
    {
        public string Id { get; set; } = Guid.NewGuid().ToString();
        public string TenantId { get; set; }
        public string ProjectId { get; set; }
        public string Filename { get; set; }
        public string FilePath { get; set; }
        public DateTime UploadedAt { get; set; } = DateTime.UtcNow;
    }

    public class AuditEvent
    {
        public string Id { get; set; } = Guid.NewGuid().ToString();
        public string TenantId { get; set; }
        public string ProjectId { get; set; }
        public string Action { get; set; }
        public string Status { get; set; }
        public string Detail { get; set; }
        public DateTime Timestamp { get; set; } = DateTime.UtcNow;
    }

    public class BioLabResponse
    {
        public bool DemoMode { get; set; } = true;
        public bool NotMedicalAdvice { get; set; } = true;
        public string Confidence { get; set; } = "low";
        public string ResultText { get; set; }
    }
}
