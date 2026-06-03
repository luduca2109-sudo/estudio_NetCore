using Microsoft.AspNetCore.Mvc;

namespace NetCoreAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class TelemetryController : ControllerBase
    {
        [HttpGet]
        public IActionResult GetStatus()
        {
            var telemetryData = new
            {
                ServerStatus = "Online",
                CpuUsage = "24%",
                RamUsage = "412MB",
                ActiveConnections = 12,
                UpdatedAt = DateTime.UtcNow
            };

            return Ok(telemetryData);
        }
    }
}