# Branch Stock Request

Branch Stock Request is an AL extension for Microsoft Dynamics 365 Business Central that implements stock request workflows between branches. It contains AL objects (tables, pages, codeunits, reports, tests) to create, track and process stock requests across locations.

## Features

- Create / approve / reject branch stock requests
- Transfer suggestions and change history
- Role-tailored pages for requestors and approvers
- Batch processing codeunits and status transitions
- Unit tests for core flows

## Prerequisites

- Visual Studio Code with AL Language extension
- Business Central development environment (local or Docker)
- AL development symbols for target BC version
- PowerShell + BcContainerHelper (recommended for containers)

## Quick start

1. Clone the repo:
   git clone <repo-url> .
2. Open the folder in VS Code.
3. Install AL Language extension.
4. Download symbols: `AL: Download Symbols` (Ctrl+Shift+P).
5. Configure `launch.json` (server, instance, authentication).
6. Compile & publish: `AL: Publish` to deploy to your BC sandbox/container.

## Project layout (typical)

- /src
  - Tables/
  - Pages/
  - Codeunits/
  - Reports/
  - Tests/
- app.json
- launch.json
- README.md

## Configuration

- app.json: set id, name, publisher, version and target platform.
- launch.json: set server, instance, tenant and authentication method.
- Use environment variables or secure storage for credentials when CI/CD is used.

Example app.json snippet:
{
"id": "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX",
"name": "Branch Stock Request",
"publisher": "YourCompany",
"version": "1.0.0.0",
"platform": "22.0.0.0"
}

## Running & debugging

- Ensure symbols are downloaded.
- Set breakpoints in AL objects.
- Start debugging (F5) to publish and attach to the sandbox/container.
- Use the provided permission sets or create a test user with required rights.

## Contributing

- Create issues for bugs or feature requests.
- Use feature branches and open pull requests.
- Follow repository coding conventions and include unit tests for new behavior.

## License

MIT — see LICENSE file for details.

Contact: maintainers listed in repository metadata.
