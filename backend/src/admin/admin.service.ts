import { Injectable } from '@nestjs/common';

@Injectable()
export class AdminService {
  getCategoriesCount() {
    return {
      count: 50,
    };
  }
}
