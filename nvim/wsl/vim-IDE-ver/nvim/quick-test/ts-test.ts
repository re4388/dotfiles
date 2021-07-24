
import { DynamoDBClient } from '@aws-sdk/client-dynamodb';
import {
  DeleteCommand,
  DeleteCommandInput,
  DynamoDBDocumentClient,
  GetCommand,
  GetCommandInput,
  GetCommandOutput,
  PutCommand,
  PutCommandInput,
  QueryCommand,
  QueryCommandInput,
  ScanCommand,
  ScanCommandInput,
} from '@aws-sdk/lib-dynamodb';











// NOTE:
// if set wrong region
// you can will have InvalidEndpointException
const ddbClient: DynamoDBClient = new DynamoDBClient({
  region: 'us-east-1',
  endpoint: 'https://dynamodb.us-east-1.amazonaws.com',
});

const ddbDocClient: DynamoDBDocumentClient =
  DynamoDBDocumentClient.from(ddbClient);

const TABLE_NAME = 'dev002-VF-SeriesPreprocessStatus';

enum PreprocessStatus {
  COMPLETE = 'complete',
  INCOMPLETE = 'incomplete',
}

interface SeriesPreprocessStatus {
  seriesUid: string;
  preprocessStatus: PreprocessStatus;
  preprocessStatusDate: string;
  preprocessLibraryVersion: string;
  wadoRsInstances: WadoRsInstance[] | null;
}

export interface WadoRsFrameLocations {
  [number: string]: string;
}
export interface WadoRsInstance {
  sopInstanceUid: string;
  frameLocations: WadoRsFrameLocations;
}
export interface ImageFilePreprocessStatus {
  seriesUid: string;
  imageFileUid: string;
  preprocessStatus: PreprocessStatus;
  preprocessStatusDate: string | null;
  preprocessLibraryVersion: string | null;
  wadoRsInstance: WadoRsInstance | null;
}
// interface ImageFilePreprocessStatus {
//   seriesUid: string;
//   imageFileUid: string;
//   preprocessStatus: PreprocessStatus;
//   preprocessStatusDate: string | null;
//   preprocessLibraryVersion: string | null;
// }

class SeriesRemoteCacheStatusAccess {
  private readonly SeriesPreprocessStatusSortKey = 'NA';

  /**
   * Create a new SeriesPreprocessStatus if not existed, update if it is existed
   */
  public async saveSeriesPreprocessStatus(
    sps: SeriesPreprocessStatus
  ): Promise<void> {

    const params: PutCommandInput = {
      TableName: TABLE_NAME,
      Item: {
        seriesUid: sps.seriesUid,
        imageFileUid: this.SeriesPreprocessStatusSortKey,
        preprocessStatus: PreprocessStatus.INCOMPLETE,
        preprocessStatusDate: sps.preprocessStatusDate,
        preprocessLibraryVersion: sps.preprocessLibraryVersion,
      },
    };

    try {
      await ddbDocClient.send(new PutCommand(params));
    } catch (err) {
      console.log('Error', err);
    }

  }

  public async getSeriesPreprocessStatus(
    seriesUid: string
  ): Promise<SeriesPreprocessStatus | undefined> {
    const params: GetCommandInput = {
      TableName: TABLE_NAME,
      Key: {
        seriesUid,
        imageFileUid: this.SeriesPreprocessStatusSortKey,
      },
    };
    const data: GetCommandOutput = await ddbDocClient.send(
      new GetCommand(params)
    );
    console.log(data);
    if (data.Item === undefined) {
      return undefined;
    }

    return <SeriesPreprocessStatus>data?.Item;
  }

  // public async getSeriesPreprocessStatus(
  //   seriesUid: string
  // ): Promise<SeriesPreprocessStatus | undefined> {
  //   const params: GetCommandInput = {
  //     TableName: TABLE_NAME,
  //     Key: {
  //       seriesUid,
  //       imageFileUid: this.SeriesPreprocessStatusSortKey,
  //     },
  //   };
  //   try {
  //     const data = await ddbDocClient.send(new GetCommand(params));
  //     const result: SeriesPreprocessStatus = {
  //       seriesUid: data?.Item?.seriesUid,
  //       preprocessStatus: data?.Item?.preprocessStatus,
  //       preprocessStatusDate: data?.Item?.preprocessStatusDate,
  //       preprocessLibraryVersion: data?.Item?.preprocessLibraryVersion,
  //     };

  //     return result;
  //   } catch (err) {
  //     console.log('err', err);
  //     return undefined;
  //   }
  // }

  public async deleteSeriesPreprocessStatus(seriesUid: string): Promise<void> {
    const params: DeleteCommandInput = {
      TableName: TABLE_NAME,
      Key: {
        seriesUid,
        imageFileUid: this.SeriesPreprocessStatusSortKey,
      },
    };
    try {
      await ddbDocClient.send(new DeleteCommand(params));
    } catch (err) {
      console.log('Error', err);
      return undefined;
    }
  }

  /**
   * Create a new ImageFilePreprocessStatus if not existed, update if it is existed
   */
  public async saveImageFilePreprocessStatus(
    ifps: ImageFilePreprocessStatus
  ): Promise<void> {
    const params: PutCommandInput = {
      TableName: TABLE_NAME,
      Item: {
        seriesUid: ifps.seriesUid,
        imageFileUid: ifps.imageFileUid,
        preprocessStatus: ifps.preprocessStatus,
        preprocessStatusDate: ifps.preprocessStatusDate,
        preprocessLibraryVersion: ifps.preprocessLibraryVersion,
      },
    };
    await ddbDocClient.send(new PutCommand(params));
  }

  // public async getImageFilePreprocessStatusTEST(
  //   seriesUid: string
  // ): Promise<ImageFilePreprocessStatus | undefined> {
  //   const params: GetCommandInput = {
  //     TableName: TABLE_NAME,
  //     Key: {
  //       seriesUid,
  //       imageFileUid: 'NA',
  //     },
  //   };
  //   const data = await ddbDocClient.send(new GetCommand(params));
  //   const result: ImageFilePreprocessStatus = {
  //     seriesUid: data?.Item?.seriesUid,
  //     imageFileUid: data?.Item?.imageFileUid,
  //     preprocessStatus: data?.Item?.preprocessStatus,
  //     preprocessLibraryVersion: data?.Item?.preprocessLibraryVersion,
  //     preprocessStatusDate: data?.Item?.preprocessStatusDate,
  //     wadoRsInstance: data?.Item?.WadoRsInstance,
  //   };

  //   return result;
  // }
  public async getImageFilePreprocessStatus(
    seriesUid: string,
    imageFileUid: string
  ): Promise<ImageFilePreprocessStatus | undefined> {
    const params: GetCommandInput = {
      TableName: TABLE_NAME,
      Key: {
        seriesUid,
        imageFileUid,
      },
    };
    const data = await ddbDocClient.send(new GetCommand(params));
    const result: ImageFilePreprocessStatus = {
      seriesUid: data?.Item?.seriesUid,
      imageFileUid: data?.Item?.imageFileUid,
      preprocessStatus: data?.Item?.preprocessStatus,
      preprocessLibraryVersion: data?.Item?.preprocessLibraryVersion,
      preprocessStatusDate: data?.Item?.preprocessStatusDate,
      wadoRsInstance: data?.Item?.WadoRsInstance,
    };

    return result;
  }
  public async getImageFilePreprocessStatusesBySeriesUidV4(
    seriesUid: string
  ): Promise<ImageFilePreprocessStatus[]> {
    const params: QueryCommandInput = {
      TableName: TABLE_NAME,
      KeyConditionExpression:
        'seriesUid = :seriesUidValue AND imageFileUid < :imageFileUidValue',
      ExpressionAttributeValues: {
        ':seriesUidValue': seriesUid,
        ':imageFileUidValue': 'NA',
      },
    };
    const data = await ddbDocClient.send(new QueryCommand(params));
    console.log(data);
    return <ImageFilePreprocessStatus[]>data.Items;
  }
  public async getImageFilePreprocessStatusesBySeriesUid(
    seriesUid: string
  ): Promise<ImageFilePreprocessStatus[]> {
    const params: QueryCommandInput = {
      TableName: TABLE_NAME,
      KeyConditionExpression: 'seriesUid = :sid',
      ExpressionAttributeValues: {
        ':sid': seriesUid,
      },
    };
    const data = await ddbDocClient.send(new QueryCommand(params));
    console.log(data);
    return <ImageFilePreprocessStatus[]>data.Items;
  }

  public async getImageFilePreprocessStatusesBySeriesUidV2(seriesUid: string) {
    const params: ScanCommandInput = {
      TableName: TABLE_NAME,
      FilterExpression: 'seriesUid = :sid AND imageFileUidValue <> :val',
      ExpressionAttributeValues: {
        ':val': this.SeriesPreprocessStatusSortKey,
        ':sid': seriesUid,
      },
    };
    const data = await ddbDocClient.send(new ScanCommand(params));
    console.log(data);
    return <ImageFilePreprocessStatus[]>data.Items;
  }

  public async deleteImageFilePreprocessStatus(
    seriesUid: string,
    imageFileUid: string
  ): Promise<void> {
    const params: DeleteCommandInput = {
      TableName: TABLE_NAME,
      Key: {
        seriesUid,
        imageFileUid,
      },
    };
    try {
      await ddbDocClient.send(new DeleteCommand(params));
    } catch (err) {
      console.log('Error', err);
      return undefined;
    }
  }
}

async function run() {
  const access = new SeriesRemoteCacheStatusAccess();

  // const sps1: SeriesPreprocessStatus = {
  //   seriesUid: 'A0002',
  //   preprocessStatus: PreprocessStatus.INCOMPLETE,
  //   preprocessStatusDate: '23',
  //   preprocessLibraryVersion: 'ver2',
  // };
  // await access.saveSeriesPreprocessStatus(sps1);

  // const res = await access.getSeriesPreprocessStatus('A0003');
  // console.log(res);

  // await access.deleteSeriesPreprocessStatus('s0002');

  // const spfs: ImageFilePreprocessStatus = {
  //   seriesUid: 'test_null',
  //   imageFileUid: 'XmgFile0001',
  //   preprocessStatus: PreprocessStatus.INCOMPLETE,
  //   preprocessStatusDate: null,
  //   preprocessLibraryVersion: null,
  //   wadoRsInstance: null,
  // };
  // await access.saveImageFilePreprocessStatus(spfs);

  // const res = await access.getImageFilePreprocessStatus('s0002', 'imgFile0001');
  // console.log('res', res);

  // const res = await access.getImageFilePreprocessStatusesBySeriesUid('dcdcd');
  // console.log('res', res);

  // const res = await access.getImageFilePreprocessStatusesBySeriesUidV2('1001');
  // console.log('res', res);
  const res = await access.getImageFilePreprocessStatusesBySeriesUidV2('1001');
  console.log('res', res);

  // await access.deleteImageFilePreprocessStatus('s0002', 'imgFile0001');
}

run();
