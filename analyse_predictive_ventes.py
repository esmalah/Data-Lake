from pyspark.sql import SparkSession
from pyspark.sql.functions import year, month, to_date
from pyspark.ml.feature import VectorAssembler
from pyspark.ml.regression import LinearRegression

#Session Spark avec  Hive
spark = SparkSession.builder.appName("SalesPrediction").enableHiveSupport().getOrCreate()

#Orders_Hive
orders_df = spark.sql("SELECT order_date, product_id, customer_id, quantity FROM fait_orders")
orders_df = orders_df.withColumn("order_date", to_date(orders_df["order_date"], 'MM/dd/yyyy'))
orders_df = orders_df.withColumn("year", year(orders_df["order_date"]))
orders_df = orders_df.withColumn("month", month(orders_df["order_date"]))

#Features
assembler = VectorAssembler(inputCols=["year", "month", "product_id", "customer_id"], outputCol="features")
df_prepared = assembler.transform(orders_df)

#le modèle
lr = LinearRegression(featuresCol="features", labelCol="quantity")
lr_model = lr.fit(df_prepared)

#Faire les prédictions
predictions = lr_model.transform(df_prepared)
predictions.select("features", "quantity", "prediction").write.csv("/path/to/output/predictions_ventes.csv")
