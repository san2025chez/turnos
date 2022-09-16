/* eslint-disable no-console */
import * as fs from 'fs';
import * as process from 'process';
import { exist } from './util';

function getJsonContent(path: string): any{
  const rawdata = fs.readFileSync(path);
  const jsonContent = JSON.parse(rawdata.toString());
  return jsonContent;
}

function writeJsonContent(path: string, content: Record<string, unknown>): void{
  const jsonContent = JSON.stringify(content);
  fs.writeFile(path, jsonContent, 'utf8', function(err) {
    if (err) {
      console.log(`ERROR: ${String(err)}`);
    }
  });
}

function getMockDefinition(path: string): any{
  if(!fs.existsSync(`${path}/definition.json`)){
    return undefined;
  }
  const mockDefiniton = getJsonContent(`${path}/definition.json`);
  if(!fs.existsSync(`${path}/endpoints`)){
    return undefined;
  }
  const endpointsRoute = `${path}/endpoints`;
  const endpoints = fs.readdirSync(endpointsRoute);
  endpoints.forEach((endpoint) =>{
    // Logger.log(`Working on endpoint: ${endpoint}`);
    console.log(`Working on endpoint: ${endpoint}`);
    const endpointConfiguration = getJsonContent(`${endpointsRoute}/${endpoint}`);
    mockDefiniton.routes.push(endpointConfiguration.data[0].item);
  });
  return mockDefiniton;
}

function mockAssembler(): void {
  const mainPath = exist(process.argv[2])? process.argv[2] : './';
  const readMainPath = fs.readdirSync(mainPath);
  const mocksDefinitionFile = readMainPath.find((element) => element.includes('.json'));
  const mockDefinitionJson = getJsonContent(`${mainPath}/${mocksDefinitionFile}`);
  readMainPath.forEach((child) =>{
    if (fs.lstatSync(`${mainPath}/${child}`).isDirectory()) {
      console.log(`Working on subDirectory: ${child}`);
      const subMockDefinition = getMockDefinition(`${mainPath}/${child}`);
      if(exist(subMockDefinition)){
        mockDefinitionJson.data.push({
          type: 'environment',
          item : subMockDefinition
        });
      }
      else{
        console.log(`Directory ${child} does not have a proper configuration structure`);
      }
    }
  });
  const writeFile = exist(process.argv[3])? process.argv[3] : './finalConfig.json';
  // TODO: ADD MULTIPLE MOCKS MANAGEMENT ON DOCKER FOR THIS TO WORK
  writeJsonContent(writeFile, mockDefinitionJson.data[0].item);
  return ;
}

mockAssembler();
