/**
 * QSFileManager.m
 * 
 * Copyright (c) 2010 - 2011, Quasidea Development, LLC
 * For more information, please go to http://www.quasidea.com/
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#import "QSFileManager.h"

static NSString * _strDocumentsPath = nil;

@implementation QSFileManager

+ (NSString *)documentsFilePathForFile:(NSString *)strFile {
	if (_strDocumentsPath == nil) {
		NSArray * objPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true);
		_strDocumentsPath = [objPaths objectAtIndex:0];
		[_strDocumentsPath retain];
	}

	return [_strDocumentsPath stringByAppendingPathComponent:strFile];
}

+ (bool)writeFile:(NSString *)strFilePath WithData:(NSData *)objData {
	return [[NSFileManager defaultManager] createFileAtPath:strFilePath contents:objData attributes:nil];
}

+ (NSData *)readFile:(NSString *)strFilePath {
	return [[NSFileManager defaultManager] contentsAtPath:strFilePath];
}

+ (bool)writeDocumentsFile:(NSString *)strFileName WithData:(NSData *)objData {
	return [QSFileManager writeFile:[QSFileManager documentsFilePathForFile:@"qcodo_large.tif"] WithData:objData];
}

+ (NSData *)readDocumentsFile:(NSString *)strFileName {
	return [QSFileManager readFile:[QSFileManager documentsFilePathForFile:strFileName]];
}

+ (NSInteger)fileSize:(NSString *)strFilePath {
	NSDictionary * dctFileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:strFilePath error:NULL];	
	return [dctFileAttributes fileSize];
}

@end
