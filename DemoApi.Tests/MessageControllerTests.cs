using DemoApi.Controllers;
using Microsoft.AspNetCore.Mvc;
using System;
using Xunit;

namespace DemoApi.Tests
{
    public class MessageControllerTests
    {
        [Fact]
        public void Check_with_message_hello()
        {
            var controller = new MessageController();
            var output = controller.Get("hello").Value;
            Assert.Equal("hi", output);
        }

        [Fact]
        public void Check_with_message_hi()
        {
            var controller = new MessageController();
            var output = controller.Get("hi").Value;
            Assert.Equal("hello", output);
        }

        [Fact]
        public void Check_with_message_invalid()
        {
            var controller = new MessageController();
            var output = controller.Get("h").Value;
            Assert.Equal("Invalid", output);
        }
    }
}