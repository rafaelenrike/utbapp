var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/", () => "<h1><center>Infraestructura para TI</center></h1>");

app.Run();
