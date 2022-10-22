var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/", () => "Hola muchachos. Espero que les guste el tema");

app.Run();
