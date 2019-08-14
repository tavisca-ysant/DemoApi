using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DemoApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class MessageController : ControllerBase
    {
        [HttpGet]
        public IEnumerable<string> Get()
        {
            return new string[]
            {
                "value1",
                "value2"
            };
        }

        [HttpGet("{message}")]
        public ActionResult<string> Get(string message)
        {
            if (message == "hi")
                return "hello";
            else if (message == "hello")
                return "hi";
            return "Invalid";
        }
    }
}
