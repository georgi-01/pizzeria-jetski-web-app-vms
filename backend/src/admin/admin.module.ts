import { Module } from '@nestjs/common';

import { AdminController } from './admin.controller';
import { AdminService } from './admin.service';

import { CategoriesModule } from '../categories/categories.module';
import { IngredientsModule } from '../ingredients/ingredients.module';
import { EmployeesModule } from '../employees/employees.module';

@Module({
  imports: [
    CategoriesModule,
    IngredientsModule,
    EmployeesModule,
  ],
  controllers: [AdminController],
  providers: [AdminService],
})
export class AdminModule {}
