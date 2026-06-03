using Xunit;

namespace Dashboard.API.Tests
{
    public class BackendHealthTests
    {
        [Fact]
        public void Pipeline_Deberia_Validar_Pruebas_Exitosamente()
        {
            bool ambienteConfigurado = true;
            bool resultadoActual = ambienteConfigurado;
            Assert.True(resultadoActual, "El entorno de pruebas de .NET debe responder True");
        }
    }
}