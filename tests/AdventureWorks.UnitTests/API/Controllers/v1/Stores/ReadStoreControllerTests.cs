﻿using AdventureWorks.API.Controllers.v1.Stores;
using AdventureWorks.Application.Interfaces.Services.Stores;
using AdventureWorks.Domain.Models.Sales;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System.Net;

namespace AdventureWorks.UnitTests.API.Controllers.v1.Stores;

[ExcludeFromCodeCoverage]
public sealed class ReadStoreControllerTests : UnitTestBase
{
    private readonly Mock<ILogger<ReadStoreController>> _mockLogger = new();
    private readonly Mock<IReadStoreService> _mockReadStoreService = new();
    private readonly ReadStoreController _sut;

    public ReadStoreControllerTests()
    {
        _sut = new ReadStoreController(_mockLogger.Object, _mockReadStoreService.Object);
    }
    
    [Fact]
    public void Controller_throws_correct_exceptions()
    {
        using (new AssertionScope())
        {
            _ = ((Action)(() => _ = new ReadStoreController(null!, _mockReadStoreService.Object)))
                .Should().Throw<ArgumentNullException>("because we expect a null argument exception.")
                .And.ParamName.Should().Be("logger");

            _ = ((Action)(() => _ = new ReadStoreController(_mockLogger.Object, null!)))
                .Should().Throw<ArgumentNullException>("because we expect a null argument exception.")
                .And.ParamName.Should().Be("readStoreService");
        }
    }

    [Fact]
    public async Task GetById_returns_ok_Async()
    {
        const int id = 7;

        _mockReadStoreService.Setup(x => x.GetByIdAsync(It.IsAny<int>()))
            .ReturnsAsync(new StoreModel { Id = id });

        var result = await _sut.GetByIdAsync(7).ConfigureAwait(false);

        var objectResult = result as ObjectResult;

        using (new AssertionScope())
        {
            objectResult.Should().NotBeNull();

            objectResult!.StatusCode.Should().Be((int)HttpStatusCode.OK);
        }
    }

    [Fact]
    public async Task GetById_returns_not_found_Async()
    {
        _mockReadStoreService.Setup(x => x.GetByIdAsync(It.IsAny<int>()))
            .ReturnsAsync((StoreModel?)null);

        var result = await _sut.GetByIdAsync(7).ConfigureAwait(false);
        var objectResult = result as NotFoundObjectResult;
        var outputModel = objectResult!.Value! as string;

        using (new AssertionScope())
        {
            objectResult.Should().NotBeNull();
            objectResult!.StatusCode.Should().Be((int)HttpStatusCode.NotFound);

            outputModel.Should().NotBeNull();
            outputModel!.Should().Be("Unable to locate Store.");
        }
    }

    [Theory]
    [InlineData(0)]
    [InlineData(-1)]
    [InlineData(-10)]
    public async Task GetById_returns_bad_request_Async(int addressId)
    {
        var result = await _sut.GetByIdAsync(addressId).ConfigureAwait(false);
        var objectResult = result as BadRequestObjectResult;
        var outputModel = objectResult!.Value! as string;

        using (new AssertionScope())
        {
            objectResult.Should().NotBeNull();
            objectResult!.StatusCode.Should().Be((int)HttpStatusCode.BadRequest);

            outputModel.Should().NotBeNull();
            outputModel!.Should().Be("A valid store id must be specified.");
        }
    }
}
