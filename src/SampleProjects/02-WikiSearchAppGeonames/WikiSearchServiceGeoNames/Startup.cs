using CSD.WikiSearchApp.Data.DAL;
using CSD.WikiSearchApp.Data.Repositories;
using CSD.WikiSearchApp.Data.Repositories.Contexts;
using CSD.WikiSearchApp.Data.Services;
using CSD.WikiSearchApp.Geonames;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.HttpsPolicy;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.OpenApi.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using CSD.Util.Mappers;
using CSD.Util.Mappers.Mapster;
using System.Threading;

namespace WikiSearchServiceGeoNames
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {

            services.AddControllers();
            services.AddSwaggerGen(c =>
            {
                c.SwaggerDoc("v1", new OpenApiInfo { Title = "WikiSearchServiceGeoNames", Version = "v1" });
            });

            //For DI

            services
                .AddHttpClient()
                .AddSingleton<WikiSearchClient>()
                .AddSingleton<WikiSearchAppDbContext>()
                .AddSingleton(typeof(IWikiSearchRepository), typeof(WikiSearchRepository))
                .AddSingleton<IWikiSearchRepository, WikiSearchRepository>()
                .AddSingleton<WikiSearchAppDataHelper>()
                .AddSingleton<WikiSearchAppService>()
                .AddSingleton<IMapper, Mapper>();
                
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
                app.UseSwagger();
                app.UseSwaggerUI(c => c.SwaggerEndpoint("/swagger/v1/swagger.json", "WikiSearchServiceGeoNames v1"));
            }

            app.UseHttpsRedirection();

            app.UseRouting();

            app.UseAuthorization();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
            });

            //Tamamen örnek amaçlı yazılmıştır. Arka plan bir iş (job) için uygun olabilir. Şüphesiz yeri burası olmak zorunda değildir
            new Timer(_ => Console.Write("."), null, 3000, 3000); 
        }       
    }
}
